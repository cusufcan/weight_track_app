import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_icons.dart';

import '../../../constants/project_strings.dart';

class ProjectAppBar extends StatelessWidget with PreferredSizeWidget, ProjectIcons, ProjectStrings {
  ProjectAppBar({super.key, required this.hasSettingsIcon, this.languageIndex});
  final bool hasSettingsIcon;
  final int? languageIndex;
  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text(ProjectStrings.appName), actions: [
      if (hasSettingsIcon)
        Center(
            child: IconButton(
          tooltip: findString(languageIndex ?? 0, LanguagesEnum.settings),
          icon: icSettings,
          onPressed: () {},
        ))
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
