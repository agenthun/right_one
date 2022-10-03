import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:right_one/repository/cp_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _getUserProfile() async {
    var data = await CpRepository().getRecommend();
    // data = await CpRepository().getUserProfile(3018527);
    // data = await CpRepository().getUserProfile(171956);
    // data = await CpRepository().getUserProfile(1798446);
    // data = await CpRepository().getUserProfile(1609771);
    // data = await CpRepository().getUserProfile(5964583);
    // data = await CpRepository().getUserProfile(4626676);
    log("$data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getUserProfile();
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}
