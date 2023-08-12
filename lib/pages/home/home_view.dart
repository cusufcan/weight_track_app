import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_colors.dart';
import 'package:weight_track_app/constants/project_icons.dart';
import 'package:weight_track_app/pages/home/home_view_model.dart';
import 'package:weight_track_app/utils/ui/appBar/custom_app_bar.dart';
import 'package:weight_track_app/utils/ui/button/custom_delete_btn.dart';
import 'package:weight_track_app/utils/ui/card/data_card.dart';

import '../../constants/project_radius.dart';
import '../../utils/services/cache/shared_manager.dart';
import '../../utils/ui/button/custom_floating_btn.dart';
import '../../utils/ui/chart/line_chart_view.dart';
import '../../utils/ui/listView/custom_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, this.manager});
  // SharedManager
  final SharedManager? manager;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel with ProjectColors, ProjectIcons {
  @override
  Widget build(BuildContext context) {
    views = [
      WeightListView(
        key: listViewKey,
        data: dataList,
        update: (value) => updateCardData(),
        isLoading: isLoading,
        languageIndex: languageIndex ?? 0,
        changeFloating: changeFloating,
        resetFloating: resetFloating,
        changeFloatingActive: changeFloatingActive,
        activateFloatingDelete: activateFloatingDelete,
      ),
      LineChartView(data: dataList, languageIndex: languageIndex ?? 0),
    ];
    setState(initLocalization);
    return WillPopScope(
      onWillPop: () async {
        if (isFloatingDelete) {
          listViewKey.currentState?.resetSelectedItems();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          appBar: ProjectAppBar(
            languageIndex: languageIndex,
            hasCancelIcon: isFloatingDelete,
            cancelBtnOnPressed: listViewKey.currentState?.resetSelectedItems,
            manager: widget.manager,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(ProjectRadius().radiusNormal)),
            ),
            child: BottomNavigationBar(
              backgroundColor: white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              onTap: (value) {
                selectedIndex = value;
                value == 1 ? isFloatingActive = false : isFloatingActive = true;
                setState(() {});
              },
              currentIndex: selectedIndex,
              items: [
                BottomNavigationBarItem(label: '0', icon: icList),
                BottomNavigationBarItem(label: '1', icon: icChart),
              ],
            ),
          ),
          floatingActionButton: isFloatingActive
              ? (!isFloatingDelete
                  ? FloatingButtonAdd(onPressed: () => showCustomBottomSheet(context))
                  : FloatingButtonDelete(
                      onPressed:
                          isFloatingActiveOnDelete ? () => listViewKey.currentState?.deleteSelectedItems() : null))
              : null,
          floatingActionButtonLocation: getFloatingLocation(),
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
                Expanded(child: views.elementAt(selectedIndex)),
              ]))),
    );
  }
}
