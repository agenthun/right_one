import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:right_one/data/cp_candidate_list.dart';
import 'package:right_one/repository/cp_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _streamController = StreamController<CpCandidateList>();
  bool _retry = false;

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
    CpCandidateList? data = result["data"];
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
      child: StreamBuilder<CpCandidateList>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (_retry) {
            return _buildLoading();
          }
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Scaffold(
                body: _buildCpCandidateList(
                    context, snapshot.data?.list ?? List.empty()),
                backgroundColor: Theme.of(context).colorScheme.onBackground,
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

  Widget _buildCpCandidateList(BuildContext context, List<CpCandidate> list) =>
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
                          subtitle: Text(cpCandidate.cpStateDesc),
                          trailing: Text(cpCandidate.cpSource),
                          onTap: () {
                            Get.toNamed("/user_profile",
                                arguments: {"uid": cpCandidate.fuid});
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
