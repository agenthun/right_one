import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:right_one/api/api_const.dart';
import 'package:right_one/api/cp_transformer.dart';
import 'package:right_one/data/cp_candidate_wrapper.dart';
import 'package:right_one/repository/cp_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _streamController = StreamController<List<CpCandidateWrapper>>();
  bool _retry = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCpCandidateList();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  Future<void> _getCpCandidateList() async {
    var result = await CpRepository().getCpCandidateList();
    Exception? error = result["error"];
    List<CpCandidateWrapper>? data = result["data"];
    var heartBeatMeResult = await CpRepository().getHeartBeatMeList();
    List<CpCandidateWrapper>? heartBeatMeResultData = heartBeatMeResult["data"];
    var hasHeartBeatMe =
        heartBeatMeResultData != null && heartBeatMeResultData.isNotEmpty;
    if (_retry) {
      setState(() {
        _retry = false;
      });
    }
    if (error != null) {
      if (hasHeartBeatMe) {
        _streamController.sink.add(heartBeatMeResultData);
      } else {
        _streamController.sink.addError(error);
      }
    } else if (data == null) {
      if (hasHeartBeatMe) {
        _streamController.sink.add(heartBeatMeResultData);
      } else {
        _streamController.sink.addError(Exception("CpCandidateList is null"));
      }
    } else {
      List<CpCandidateWrapper> list = List.from(data);
      if (hasHeartBeatMe) {
        list.addAll(heartBeatMeResultData);
      }
      _streamController.sink.add(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: StreamBuilder<List<CpCandidateWrapper>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (_retry) {
            return _buildLoading();
          }
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        _showTokenSettingsDialog();
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: _getCpCandidateList,
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: _buildCpCandidateList(
                      context, snapshot.data ?? List.empty()),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed("/recommend");
                  },
                  heroTag: "home_fab_tag_recommend",
                  child: const Icon(Icons.favorite),
                ),
              );
            } else {
              var msg = snapshot.hasError ? "出错啦: ${snapshot.error}" : "出错啦!";
              var isLoginError = snapshot.error is DioError &&
                  (snapshot.error as DioError).error is ApiError &&
                  ((snapshot.error as DioError).error as ApiError).code == 1000;
              return _buildError(context, msg, isLoginError);
            }
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Future<void> _showTokenSettingsDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
          title: const Text("设置token"),
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: "token",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '请输入token';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          token = _textEditingController.value.text;
                          Navigator.pop(context);
                          setState(() {
                            _retry = true;
                          });
                          _getCpCandidateList();
                        }
                      },
                      child: const Text("确认"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildCpCandidateList(
          BuildContext context, List<CpCandidateWrapper> list) =>
      SafeArea(
        top: true,
        child: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 64),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var cpCandidate = list[index];
                        return ListTile(
                          leading: SizedBox.square(
                            dimension: 48,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: cpCandidate.avatar,
                              placeholder: (context, url) => _buildLoading(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image_rounded),
                            ),
                          ),
                          title: Text(cpCandidate.nickname),
                          subtitle: cpCandidate.cpStateDesc != null
                              ? Text(cpCandidate.cpStateDesc ?? "")
                              : null,
                          trailing: Text(cpCandidate.cpSource),
                          onTap: () {
                            var uid = cpCandidate.uid;
                            if (uid != null) {
                              Get.toNamed("/user_profile",
                                  arguments: {"uid": uid});
                            }
                          },
                        );
                      },
                      childCount: list.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

  Widget _buildError(BuildContext context, String msg, bool isLoginError) =>
      Column(
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
                    if (isLoginError) {
                      _showTokenSettingsDialog();
                      return;
                    }
                    setState(() {
                      _retry = true;
                    });
                    _getCpCandidateList();
                  },
                  child: const Text(
                    "再试一次",
                  )),
            ),
          ),
        ],
      );
}
