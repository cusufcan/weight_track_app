import 'package:flutter/material.dart';

import 'theme_light.dart';

enum Themes { light, dark }

extension ThemeExtension on Themes {
  ThemeData get theme {
    switch (this) {
      case Themes.light:
        return ThemeLight().theme;
      case Themes.dark:
        return ThemeData.dark(); // dark theme eklenince değişecek
    }
  }
}
