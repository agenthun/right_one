import 'package:get/get.dart';
import 'package:right_one/views/home/home.dart';
import 'package:right_one/views/recommend/recommend_page.dart';
import 'package:right_one/views/user_profile/user_profile_page.dart';

List<GetPage> pages = [
  GetPage(
    name: "/home",
    page: () => const Home(),
    transition: Transition.topLevel,
  ),
  GetPage(
    name: "/user_profile",
    page: () => const UserProfilePage(),
    transition: Transition.topLevel,
  ),
  GetPage(
    name: "/recommend",
    page: () => const RecommendPage(),
    transition: Transition.topLevel,
  ),
];
