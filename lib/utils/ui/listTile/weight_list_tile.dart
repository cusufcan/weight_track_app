import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_track_app/constants/project_colors.dart';
import 'package:weight_track_app/constants/project_icons.dart';
import 'package:weight_track_app/utils/ui/text/subtitle_text.dart';

import '../text/title_text.dart';

class WeightListTile extends StatefulWidget {
  const WeightListTile(
      {super.key,
      required this.date,
      required this.weight,
      this.onTap,
      required this.visible,
      this.onLongPress,
      required this.icon});
  final DateTime date;
  final double weight;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final bool visible;
  final Widget icon;
  @override
  State<WeightListTile> createState() => _WeightListTileState();
}

class _WeightListTileState extends State<WeightListTile> with ProjectColors, ProjectIcons {
  final String _kilogram = 'kg';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Stack(alignment: Alignment.centerRight, children: [
        ListTile(
          leading: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ProjectIcons().icWeight]),
          tileColor: Theme.of(context).colorScheme.background.withOpacity(0.6),
          title: CustomTitleText(text: '${widget.weight}$_kilogram'),
          subtitle: CustomSubTitleText(text: DateFormat.yMMMMd().format(widget.date)),
        ),
        Positioned(right: 20, child: Visibility(visible: widget.visible, child: widget.icon)),
      ]),
    );
  }
}
