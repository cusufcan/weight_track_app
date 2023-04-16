import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_colors.dart';
import 'package:weight_track_app/constants/project_icons.dart';
import 'package:weight_track_app/constants/project_paddings.dart';

class DeleteDismissible extends StatelessWidget with ProjectIcons, ProjectPaddings, ProjectColors {
  DeleteDismissible({super.key, required this.valueKey, this.onDismissed, required this.child});
  final ValueKey<DateTime> valueKey;
  final void Function(DismissDirection)? onDismissed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.startToEnd,
        background: Container(
          color: red,
          padding: paddingHorizontalNormal,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [icDelete]),
        ),
        key: valueKey,
        onDismissed: onDismissed,
        child: child);
  }
}
