import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:right_one/data/like_result.dart';
import 'package:right_one/data/user_profile.dart';
import 'package:right_one/repository/cp_repository.dart';
import 'package:right_one/views/user_profile/user_profile_widget.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  final _streamController = StreamController<UserProfile>();
  bool _retry = false;
  UserProfile? _dailyRecommendData;

  @override
  void initState() {
    super.initState();
    _getRecommendUserProfile();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  Future<void> _getRecommendUserProfile() async {
    var result = await CpRepository().getRecommend();
    Exception? error = result["error"];
    UserProfile? data = result["data"];
    if (_retry) {
      setState(() {
        _retry = false;
      });
    }
    var ignoreDailyRecommend = false;
    if (data == null) {
      result = await CpRepository().getDailyRecommend();
      error = result["error"];
      data = result["data"];
      if (_dailyRecommendData?.uid != null &&
          _dailyRecommendData?.uid == data?.uid) {
        ignoreDailyRecommend = true;
      }
      _dailyRecommendData = data;
    }
    if (data == null || ignoreDailyRecommend) {
      result = await CpRepository().getRandomRecommend();
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
              );
            } else {
              var msg = snapshot.hasError ? "出错啦: ${snapshot.error}" : "出错啦!";
              return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  backgroundColor: Theme.of(context).colorScheme.onBackground,
                ),
                body: _buildError(context, msg),
                backgroundColor: Theme.of(context).colorScheme.onBackground,
              );
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
      Stack(
        children: [
          UserProfileWidget(
            profile: profile,
            actions: [
              IconButton(
                onPressed: () {
                  _getRecommendUserProfile();
                },
                icon: const Icon(Icons.skip_next),
              ),
            ],
          ),
          _buildLikeControlView(context, profile),
        ],
      );

  Widget _buildLikeControlView(BuildContext context, UserProfile profile) =>
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
          ));

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
