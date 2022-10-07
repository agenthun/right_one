import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:right_one/data/user_profile.dart';
import 'package:right_one/repository/cp_repository.dart';
import 'package:right_one/views/user_profile/user_profile_widget.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, dynamic> args = Get.arguments;

  int get _uid => args["uid"];

  final _streamController = StreamController<UserProfile>();
  bool _retry = false;

  @override
  void initState() {
    super.initState();
    _getUserProfile(_uid);
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  Future<void> _getUserProfile(int uid) async {
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
      UserProfileWidget(profile: profile);

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
                    _getUserProfile(_uid);
                  },
                  child: const Text(
                    "再试一次",
                  )),
            ),
          ),
        ],
      );
}
