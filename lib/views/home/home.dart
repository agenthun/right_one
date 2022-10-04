import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:right_one/data/like_result.dart';
import 'package:right_one/data/user_profile.dart';
import 'package:right_one/repository/cp_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _streamController = StreamController<UserProfile>();
  bool _retry = false;
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _getRecommendUserProfile();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _player.dispose();
  }

  Future<void> _getUserProfile(int uid) async {
    _stopAudio();
    var result = await CpRepository().getUserProfile(uid);
    Exception? error = result["error"];
    UserProfile? data = result["data"];
    if (_retry) {
      setState(() {
        _retry = false;
      });
    }
    if (error != null) {
      _streamController.sink.addError(error);
    } else if (data == null) {
      _streamController.sink.addError(Exception("UserProfile is null"));
    } else {
      _streamController.sink.add(data);
    }
  }

  Future<void> _getRecommendUserProfile() async {
    _stopAudio();
    var result = await CpRepository().getRecommend();
    Exception? error = result["error"];
    UserProfile? data = result["data"];
    if (_retry) {
      setState(() {
        _retry = false;
      });
    }
    if (data == null) {
      result = await CpRepository().getDailyRecommend();
      error = result["error"];
      data = result["data"];
    }
    if (error != null) {
      _streamController.sink.addError(error);
    } else if (data == null) {
      _streamController.sink.addError(Exception("UserProfile is null"));
    } else {
      _streamController.sink.add(data);
    }
  }

  Future<void> _initAudio(String url) async {
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    } catch (e) {
      log("_initAudio, error, $e");
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _player.stop();
    } catch (e) {
      log("_stopAudio, error, $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: StreamBuilder<UserProfile>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (_retry) {
            return _buildLoading();
          }
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Scaffold(
                body: _buildUserProfileView(context, snapshot.data!),
                backgroundColor: Theme.of(context).colorScheme.onBackground,
              );
            } else {
              var msg = snapshot.hasError ? "出错啦: ${snapshot.error}" : "出错啦!";
              return _buildError(context, msg);
            }
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildUserProfileView(BuildContext context, UserProfile profile) =>
      Scaffold(
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      flexibleSpace: SizedBox.expand(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: profile.headerPhoto,
                          placeholder: (context, url) => _buildLoading(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.broken_image_rounded,
                            size: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ),
                      ),
                      expandedHeight: 350,
                      elevation: 0,
                    ),
                  )
                ];
              },
              body: SafeArea(
                top: false,
                bottom: true,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 64),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                switch (index) {
                                  case 0:
                                    return ListTile(
                                      leading: SizedBox.square(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: profile.avatar,
                                          placeholder: (context, url) =>
                                              _buildLoading(),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.broken_image_rounded,
                                          ),
                                        ),
                                        dimension: 48,
                                      ),
                                      title: Text(profile.nickname),
                                      subtitle: Text(
                                          "${profile.address} • ${profile.sexDes} • ${profile.age}岁"),
                                      trailing:
                                          Text("${profile.constellation}"),
                                    );
                                  case 1:
                                    return Column(
                                      children: [
                                        const Divider(),
                                        ListTile(
                                          title: Text("家乡"),
                                          trailing: Text(
                                              "${profile.basicInfo.hometown}"),
                                        ),
                                      ],
                                    );
                                  case 2:
                                    return ListTile(
                                      title: Text("学校"),
                                      trailing:
                                          Text("${profile.basicInfo.school}"),
                                    );
                                  case 3:
                                    return ListTile(
                                      title: Text("学籍状态"),
                                      trailing:
                                          Text("${profile.basicInfo.work}"),
                                    );
                                  case 4:
                                    return ListTile(
                                      title: Text("身高"),
                                      trailing: Text(
                                          "${profile.privacy.detail.height}"),
                                    );
                                  case 5:
                                    return ListTile(
                                      title: Text("年收入"),
                                      trailing: Text(
                                          "${profile.privacy.detail.annualIncome}"),
                                    );
                                  case 6:
                                    return ListTile(
                                      title: Text("职业"),
                                      trailing: Text(
                                          "${profile.privacy.detail.career}"),
                                    );
                                  case 7:
                                    return ListTile(
                                      title: Text("谈过几次恋爱"),
                                      trailing: Text(
                                          "${profile.privacy.detail.loveStory}"),
                                    );
                                  case 8:
                                    return Column(
                                      children: [
                                        const Divider(),
                                        ListTile(
                                          title: Text("描述自己的外貌"),
                                          subtitle: Text(
                                              "${profile.moreInfo.appearance}"),
                                        ),
                                      ],
                                    );
                                  case 9:
                                    return ListTile(
                                      title: Text("对未来的规划"),
                                      subtitle:
                                          Text("${profile.moreInfo.future}"),
                                    );
                                  case 10:
                                    return ListTile(
                                      title: Text("成长经历"),
                                      subtitle:
                                          Text("${profile.moreInfo.growUp}"),
                                    );
                                  case 11:
                                    return ListTile(
                                      title: Text("你觉得最浪漫的事情是"),
                                      subtitle:
                                          Text("${profile.moreInfo.romantic}"),
                                    );
                                  case 12:
                                    return ListTile(
                                      title: Text("去过的地方"),
                                      subtitle:
                                          Text("${profile.moreInfo.travel}"),
                                    );
                                  case 13:
                                    return ListTile(
                                      title: Text("什么样的CP会吸引你"),
                                      subtitle:
                                          Text("${profile.moreInfo.whatCp}"),
                                    );
                                  case 14:
                                    return Column(
                                      children: [
                                        const Divider(),
                                        ListTile(
                                          title: Text("个性标签"),
                                          subtitle:
                                              Text(profile.tagKeys.join(", ")),
                                        ),
                                      ],
                                    );
                                  case 15:
                                    return ListTile(
                                      title: Text("音色测评"),
                                      subtitle: Text(
                                          "${profile.userAudioInfo?.mainAudioDesc}, ${profile.userAudioInfo?.deputyAudioDesc}"),
                                      trailing: StreamBuilder<PlayerState>(
                                        stream: _player.playerStateStream,
                                        builder: (context, snapshot) {
                                          final playerState = snapshot.data;
                                          final processingState =
                                              playerState?.processingState;
                                          final playing = playerState?.playing;
                                          if (processingState ==
                                                  ProcessingState.loading ||
                                              processingState ==
                                                  ProcessingState.buffering) {
                                            return IconButton(
                                                onPressed: null,
                                                icon: Container(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                ));
                                          } else if (playing == true &&
                                              processingState !=
                                                  ProcessingState.completed) {
                                            return IconButton(
                                              icon: const Icon(Icons.pause),
                                              onPressed: _player.pause,
                                            );
                                          } else {
                                            return IconButton(
                                              icon:
                                                  const Icon(Icons.play_arrow),
                                              onPressed: () async {
                                                var url = profile
                                                    .userAudioInfo?.audioUrl;
                                                if (url != null) {
                                                  await _initAudio(url);
                                                  await _player.play();
                                                }
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    );
                                }
                              },
                              childCount:
                                  15 + (profile.userAudioInfo != null ? 1 : 0),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SafeArea(
                bottom: true,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          var uid = profile.uid;
                          if (uid == null) return;
                          var result = await CpRepository().unlike(uid);
                          Exception? error = result["error"];
                          if (error == null) {
                            _getRecommendUserProfile();
                          }
                        },
                        heroTag: "user_profile_fab_tag_unlike",
                        child: const Icon(Icons.close),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          var uid = profile.uid;
                          if (uid == null) return;
                          var result = await CpRepository().like(uid);
                          Exception? error = result["error"];
                          LikeResult? data = result["data"];
                          if (error == null) {
                            _getRecommendUserProfile();
                          }
                        },
                        heroTag: "user_profile_fab_tag_like",
                        child: const Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      );

  Widget _buildError(BuildContext context, String msg) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_rounded,
            size: MediaQuery.of(context).size.height * 0.16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              msg,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: MediaQuery.of(context).size.height * 0.05),
            child: AspectRatio(
              aspectRatio: (MediaQuery.of(context).size.width * 0.2) /
                  (MediaQuery.of(context).size.height / 42.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _retry = true;
                    });
                    _getRecommendUserProfile();
                  },
                  child: const Text(
                    "再试一次",
                  )),
            ),
          ),
        ],
      );
}
