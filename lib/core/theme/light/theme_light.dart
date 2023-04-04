import 'package:flutter/material.dart';
import 'package:weight_track_app/core/constant/project_radius.dart';
import 'package:weight_track_app/core/theme/light/theme_light_colors.dart';

class ThemeLight with ThemeLightColors {
  late ThemeData theme;

  ThemeLight() {
    theme = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(ProjectRadius().radiusNormal))),
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
