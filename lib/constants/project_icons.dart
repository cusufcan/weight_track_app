import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_colors.dart';

class ProjectIcons {
  final Icon icAdd = Icon(Icons.add_outlined, color: ProjectColors().whiteWithOpacity);
  final Icon icDelete = Icon(Icons.delete_outlined, color: ProjectColors().whiteWithOpacity);
  final Icon icWeight = const Icon(Icons.monitor_weight_outlined);

  // Tabbar
  final Icon icList = const Icon(Icons.list);
  final Icon icChart = const Icon(Icons.show_chart);

  // ListView
  final Icon icCheck = Icon(Icons.check_circle_outlined, size: 30, color: ProjectColors().red);
  final Icon icUncheck = Icon(Icons.radio_button_unchecked_outlined, size: 30, color: ProjectColors().red);
  final Icon icCancel = const Icon(Icons.close_outlined);
  final Icon icSelectAll = const Icon(Icons.select_all_outlined);
}
