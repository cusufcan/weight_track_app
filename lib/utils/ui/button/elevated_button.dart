import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_paddings.dart';
import 'package:weight_track_app/constants/project_radius.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.text, required this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: ProjectPaddings().paddingVerticalMed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ProjectRadius().radiusNormal))),
      child: Text(text),
    );
  }
}
