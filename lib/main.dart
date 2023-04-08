import 'package:flutter/material.dart';
import 'package:weight_track_app/core/constant/project_strings.dart';
import 'package:weight_track_app/view/home/home_view.dart';

import 'core/theme/light/theme_light.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeDark().theme,
      theme: ThemeLight().theme,
      debugShowCheckedModeBanner: false,
      title: ProjectStrings().appName,
      routes: {
        '/': (context) => const HomeView(),
        // 'settings': (context) => const SettingsView(),
      },
    );
  }
}
