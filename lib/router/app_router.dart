import 'package:get/get.dart';
import 'package:right_one/views/home/home.dart';

List<GetPage> pages = [
  GetPage(
    name: "/home",
    page: () => const Home(),
    transition: Transition.topLevel,
  ),
];
