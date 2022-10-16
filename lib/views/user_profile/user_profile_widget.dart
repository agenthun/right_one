import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:right_one/data/user_profile.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({super.key, required this.profile});

  final UserProfile profile;

  @override
  State<StatefulWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  final _audioPlayer = AudioPlayer();

  UserProfile get _profile => widget.profile;

  @override
  void initState() {
    super.initState();
    var url = widget.profile.userAudioInfo?.audioUrl;
    if (url != null && url.isNotEmpty) {
      _initAudio(url);
    }
  }

  @override
  void didUpdateWidget(UserProfileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile != widget.profile) {
      _audioPlayer.stop();
      var url = widget.profile.userAudioInfo?.audioUrl;
      if (url != null && url.isNotEmpty) {
        _initAudio(url);
      }
    }
  }

  Future<void> _initAudio(String url) async {
    try {
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
    } catch (e) {
      log("_initAudio, error, $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              flexibleSpace: SizedBox.expand(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.profile.headerPhoto,
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
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
                                dimension: 48,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: _profile.avatar,
                                  placeholder: (context, url) =>
                                      _buildLoading(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.broken_image_rounded,
                                  ),
                                ),
                              ),
                              title: Text(_profile.nickname),
                              subtitle: Text(
                                  "${_profile.address} • ${_profile.sexDes} • ${_profile.age}岁"),
                              trailing: Text(_profile.constellation),
                            );
                          case 1:
                            return Column(
                              children: [
                                ListTile(
                                  title: const Text("出生年月"),
                                  trailing: Text(_profile.birthday),
                                ),
                              ],
                            );
                          case 2:
                            return Column(
                              children: [
                                const Divider(),
                                ListTile(
                                  title: const Text("家乡"),
                                  trailing:
                                      Text("${_profile.basicInfo.hometown}"),
                                ),
                              ],
                            );
                          case 3:
                            return ListTile(
                              title: const Text("学校"),
                              trailing: Text("${_profile.basicInfo.school}"),
                            );
                          case 4:
                            return ListTile(
                              title: const Text("学籍状态"),
                              trailing: Text("${_profile.basicInfo.work}"),
                            );
                          case 5:
                            return ListTile(
                              title: const Text("身高"),
                              trailing:
                                  Text("${_profile.privacy.detail.height}"),
                            );
                          case 6:
                            return ListTile(
                              title: const Text("年收入"),
                              trailing: Text(
                                  "${_profile.privacy.detail.annualIncome}"),
                            );
                          case 7:
                            return ListTile(
                              title: const Text("职业"),
                              trailing:
                                  Text("${_profile.privacy.detail.career}"),
                            );
                          case 8:
                            return ListTile(
                              title: const Text("谈过几次恋爱"),
                              trailing:
                                  Text("${_profile.privacy.detail.loveStory}"),
                            );
                          case 9:
                            return Column(
                              children: [
                                const Divider(),
                                ListTile(
                                  title: const Text("描述自己的外貌"),
                                  subtitle:
                                      Text("${_profile.moreInfo.appearance}"),
                                ),
                              ],
                            );
                          case 10:
                            return ListTile(
                              title: const Text("对未来的规划"),
                              subtitle: Text("${_profile.moreInfo.future}"),
                            );
                          case 11:
                            return ListTile(
                              title: const Text("成长经历"),
                              subtitle: Text("${_profile.moreInfo.growUp}"),
                            );
                          case 12:
                            return ListTile(
                              title: const Text("你觉得最浪漫的事情是"),
                              subtitle: Text("${_profile.moreInfo.romantic}"),
                            );
                          case 13:
                            return ListTile(
                              title: const Text("去过的地方"),
                              subtitle: Text("${_profile.moreInfo.travel}"),
                            );
                          case 14:
                            return ListTile(
                              title: const Text("什么样的CP会吸引你"),
                              subtitle: Text("${_profile.moreInfo.whatCp}"),
                            );
                          case 15:
                            return Column(
                              children: [
                                const Divider(),
                                ListTile(
                                  title: const Text("个性标签"),
                                  subtitle: Text(_profile.tagKeys.join(", ")),
                                ),
                              ],
                            );
                          case 16:
                            return ListTile(
                              title: const Text("音色测评"),
                              subtitle: Text(
                                  "${_profile.userAudioInfo?.mainAudioDesc}, ${_profile.userAudioInfo?.deputyAudioDesc}"),
                              trailing: StreamBuilder<PlayerState>(
                                stream: _audioPlayer.playerStateStream,
                                builder: (context, snapshot) {
                                  final playerState = snapshot.data;
                                  final processingState =
                                      playerState?.processingState;
                                  final playing = playerState?.playing;
                                  if (processingState ==
                                          ProcessingState.loading ||
                                      processingState ==
                                          ProcessingState.buffering) {
                                    return const IconButton(
                                        onPressed: null,
                                        icon: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ));
                                  } else if (playing == true &&
                                      processingState !=
                                          ProcessingState.completed) {
                                    return IconButton(
                                      icon: const Icon(Icons.pause),
                                      onPressed: _audioPlayer.pause,
                                    );
                                  } else {
                                    return IconButton(
                                      icon: const Icon(Icons.play_arrow),
                                      onPressed: _audioPlayer.play,
                                    );
                                  }
                                },
                              ),
                            );
                        }
                      },
                      childCount: 16 + (_profile.userAudioInfo != null ? 1 : 0),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
