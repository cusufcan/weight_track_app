import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_strings.dart';

import 'config/project_routing.dart';
import 'config/theme/theme_extension.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // darkTheme: Themes.dark.theme,
      theme: Themes.light.theme,
      title: ProjectStrings.appName,
      routes: ProjectRouting.routes,
    );
  }
}
