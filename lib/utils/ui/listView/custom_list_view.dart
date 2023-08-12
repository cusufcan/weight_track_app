import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_paddings.dart';
import 'package:weight_track_app/constants/project_radius.dart';
import 'package:weight_track_app/constants/project_strings.dart';

import '../../../constants/project_icons.dart';
import '../../../pages/home/home_model.dart';
import '../listTile/weight_list_tile.dart';

class WeightListView extends StatefulWidget with ProjectStrings, ProjectPaddings, ProjectRadius {
  WeightListView({
    required Key key,
    required this.data,
    required this.update,
    required this.isLoading,
    required this.languageIndex,
    required this.changeFloating,
    required this.resetFloating,
    required this.changeFloatingActive,
    required this.activateFloatingDelete,
  }) : super(key: key);
  final List<UserWeight> data;
  final ValueChanged update;
  final bool isLoading;
  final int languageIndex;
  final void Function() changeFloating;
  final void Function() resetFloating;
  final void Function() changeFloatingActive;
  final void Function() activateFloatingDelete;
  @override
  State<WeightListView> createState() => WeightListViewState();
}

class WeightListViewState extends State<WeightListView>
    with ProjectStrings, ProjectPaddings, ProjectIcons, TickerProviderStateMixin {
  HashSet<UserWeight> selectedItem = HashSet();
  bool isMultiSelectionEnable = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      child: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.data.isEmpty
              ? Center(child: Text(findString(widget.languageIndex, LanguagesEnum.emptyData)))
              : ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserWeight currentData = widget.data[index];
                    bool isSelected = selectedItem.contains(widget.data[index]);
                    return WeightListTile(
                        languageIndex: widget.languageIndex,
                        date: currentData.date,
                        weight: currentData.weight,
                        onTap: () => doMultiSelection(widget.data[index]),
                        onLongPress: () {
                          widget.changeFloatingActive();
                          widget.changeFloating();
                          isMultiSelectionEnable = true;
                          doMultiSelection(widget.data[index]);
                        },
                        visible: isMultiSelectionEnable,
                        icon: AnimatedSwitcher(
                            duration: const Duration(seconds: 2),
                            child: isSelected ? SizedBox(child: icCheck) : SizedBox(child: icUncheck)));
                  }),
    );
  }

  void doMultiSelection(UserWeight userWeight) {
    if (isMultiSelectionEnable) {
      if (selectedItem.contains(userWeight)) {
        selectedItem.remove(userWeight);
        if (selectedItem.isEmpty) {
          widget.changeFloatingActive();
          //? Şimdilik kaldırdım ileride tekrar aktif edebilirim.
          // widget.changeFloating();
          // isMultiSelectionEnable = false;
        }
      } else {
        widget.activateFloatingDelete();
        selectedItem.add(userWeight);
      }
      setState(() {});
    }
  }

  void removeDataItem(int index, List<UserWeight> data, ValueChanged update) {
    return setState(() {
      data.removeAt(index);
      update(true);
    });
  }

  Future<void> deleteSelectedItems() async {
    for (var element in selectedItem) {
      await Future.delayed(const Duration(milliseconds: 200));
      widget.data.remove(element);
      widget.update(true);
    }
    widget.changeFloating();
    selectedItem.clear();
    isMultiSelectionEnable = false;
    setState(() {});
  }

  void resetSelectedItems() {
    widget.resetFloating();
    selectedItem.clear();
    isMultiSelectionEnable = false;
    setState(() {});
  }
}
