import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_track_app/constants/project_strings.dart';
import 'package:weight_track_app/pages/splash/splash_view.dart';

import 'config/theme/theme_extension.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // darkTheme: Themes.dark.theme,
      theme: Themes.light.theme,
      title: ProjectStrings.appName,
      home: const SplashView(),
    );
  }
}
