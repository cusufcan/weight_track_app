import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_colors.dart';
import 'package:weight_track_app/constants/project_strings.dart';

class FloatingButtonAdd extends StatelessWidget with ProjectStrings, ProjectColors {
  FloatingButtonAdd({super.key, this.languageIndex, this.onPressed});
  final int? languageIndex;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        tooltip: findString(languageIndex ?? 0, LanguagesEnum.addData),
        onPressed: onPressed,
        child: Icon(Icons.add_outlined, color: white));
  }
}
