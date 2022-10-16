import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:right_one/db/kv.dart';
import 'package:right_one/router/app_router.dart';
import 'package:right_one/theme/app_theme.dart';

Future<void> main() async {
  await KvHolder().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.dark,
      initialRoute: "/home",
      getPages: pages,
    );
  }
}
