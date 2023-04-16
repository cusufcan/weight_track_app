import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_icons.dart';

import '../../../constants/project_strings.dart';

class ProjectAppBar extends StatelessWidget with PreferredSizeWidget, ProjectIcons, ProjectStrings {
  ProjectAppBar(
      {super.key,
      required this.hasSettingsIcon,
      this.languageIndex,
      this.cancelBtnOnPressed,
      required this.hasCancelIcon});
  final bool hasSettingsIcon;
  final int? languageIndex;
  final bool hasCancelIcon;
  final void Function()? cancelBtnOnPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(findString(languageIndex ?? 0, LanguagesEnum.appName)),
      leading: hasCancelIcon
          ? IconButton(
              onPressed: cancelBtnOnPressed,
              icon: icCancel,
              tooltip: findString(languageIndex ?? 0, LanguagesEnum.cancelSelection),
            )
          : null,
      actions: [
        if (hasSettingsIcon)
          Center(
              child: IconButton(
            tooltip: findString(languageIndex ?? 0, LanguagesEnum.settings),
            icon: icSettings,
            onPressed: () {},
          ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
