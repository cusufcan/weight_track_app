import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_colors.dart';
import 'package:weight_track_app/constants/project_icons.dart';

class CustomTabBar extends StatelessWidget with ProjectIcons, ProjectColors {
  CustomTabBar({super.key, required this.tabController, required this.views});
  final TabController tabController;
  final List<Widget> views;
  final ScrollPhysics physics = const AlwaysScrollableScrollPhysics();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: TabBarView(controller: tabController, physics: physics, children: views)),
    ]);
  }
}
