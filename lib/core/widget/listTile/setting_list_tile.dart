import 'package:flutter/material.dart';
import 'package:weight_track_app/core/constant/project_strings.dart';
import 'package:weight_track_app/core/widget/text/subtitle_text.dart';

class SettingListTile extends StatefulWidget {
  const SettingListTile({super.key, required this.icon, this.text, this.trailing});
  final Icon icon;
  final String? text;
  final Widget? trailing;
  @override
  State<SettingListTile> createState() => _SettingListTileState();
}

class _SettingListTileState extends State<SettingListTile> with ProjectStrings {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: ListTile(
        leading: widget.icon,
        tileColor: Theme.of(context).colorScheme.background.withOpacity(0.6),
        title: CustomSubTitleText(text: widget.text ?? empty),
        trailing: widget.trailing,
      ),
    );
  }
}
