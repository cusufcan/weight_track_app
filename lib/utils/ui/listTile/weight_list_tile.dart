import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_track_app/constants/project_icons.dart';
import 'package:weight_track_app/utils/ui/text/subtitle_text.dart';

import '../text/title_text.dart';

class WeightListTile extends StatefulWidget {
  const WeightListTile({super.key, required this.date, required this.weight});
  final DateTime date;
  final double weight;
  @override
  State<WeightListTile> createState() => _WeightListTileState();
}

class _WeightListTileState extends State<WeightListTile> {
  final String _kilogram = 'kg';
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ProjectIcons().icWeight]),
      tileColor: Theme.of(context).colorScheme.background.withOpacity(0.6),
      title: CustomTitleText(text: '${widget.weight}$_kilogram'),
      subtitle: CustomSubTitleText(text: DateFormat.yMMMMd().format(widget.date)),
    );
  }
}
