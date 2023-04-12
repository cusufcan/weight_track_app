import 'package:flutter/material.dart';

import '../modules/home/home_view.dart';

class ProjectRouting {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const HomeView(),
    // 'settings': (context) => const SettingsView(), // settings eklenince gelecek
  };
}
