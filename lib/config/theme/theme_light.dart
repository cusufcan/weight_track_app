import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_radius.dart';

class ThemeLight {
  late ThemeData theme;
  final Color backgroundColor = Colors.white.withOpacity(0.9);
  ThemeLight() {
    theme = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(ProjectRadius().radiusNormal),
          ),
        ),
      ),
      scaffoldBackgroundColor: backgroundColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      colorScheme: const ColorScheme.light(),
    );
  }
}
