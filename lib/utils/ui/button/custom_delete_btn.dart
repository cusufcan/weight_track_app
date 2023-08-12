import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_colors.dart';
import 'package:weight_track_app/constants/project_strings.dart';

class FloatingButtonDelete extends StatelessWidget with ProjectStrings, ProjectColors {
  FloatingButtonDelete({super.key, this.languageIndex, this.onPressed});
  final int? languageIndex;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        tooltip: findString(languageIndex ?? 0, LanguagesEnum.deleteData),
        onPressed: onPressed,
        backgroundColor: onPressed != null ? Colors.red : Colors.red.shade200,
        child: Icon(Icons.delete_outlined, color: whiteWithOpacity));
  }
}
