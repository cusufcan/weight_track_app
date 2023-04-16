import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_colors.dart';
import 'package:weight_track_app/constants/project_icons.dart';
import 'package:weight_track_app/pages/home/home_view_model.dart';
import 'package:weight_track_app/utils/ui/appBar/custom_app_bar.dart';
import 'package:weight_track_app/utils/ui/button/custom_delete_btn.dart';
import 'package:weight_track_app/utils/ui/card/data_card.dart';
import 'package:weight_track_app/utils/ui/tabBar/custom_tabbar.dart';

import '../../utils/ui/button/custom_floating_btn.dart';
import '../../utils/ui/chart/line_chart_view.dart';
import '../../utils/ui/listView/custom_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel with ProjectColors, ProjectIcons {
  @override
  Widget build(BuildContext context) {
    setState(initLocalization);
    return Scaffold(
        bottomNavigationBar: Material(
            color: white,
            child: TabBar(
                labelColor: black,
                unselectedLabelColor: black38,
                controller: tabController,
                tabs: [Tab(icon: icList), Tab(icon: icChart)])),
        appBar: ProjectAppBar(
          hasSettingsIcon: true,
          languageIndex: languageIndex,
          hasCancelIcon: isFloatingDelete,
          cancelBtnOnPressed: listViewKey.currentState?.resetSelectedItems,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: !isFloatingDelete
            ? FloatingButtonAdd(onPressed: () => showCustomBottomSheet(context))
            : FloatingButtonDelete(onPressed: () => listViewKey.currentState?.deleteSelectedItems()),
        body: Padding(
            padding: paddingTopNormal,
            child: Column(children: [
              WeightDataCard(
                currentData: currentData,
                changeData: changeData,
                weeklyData: weeklyData,
                monthlyData: monthlyData,
                languageIndex: languageIndex ?? 0,
              ),
              Expanded(
                  child: CustomTabBar(tabController: tabController, views: [
                WeightListView(
                  key: listViewKey,
                  data: dataList,
                  update: (value) => updateCardData(),
                  isLoading: isLoading,
                  languageIndex: languageIndex ?? 0,
                  changeFloating: changeFloating,
                  resetFloating: resetFloating,
                ),
                LineChartView(data: dataList, languageIndex: languageIndex ?? 0),
              ])),
            ])));
  }
}
