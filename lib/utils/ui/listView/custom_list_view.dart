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
    required this.isSelectedAll,
    required this.activateSelectAll,
    required this.resetSelectAll,
  }) : super(key: key);
  final List<UserWeight> data;
  final ValueChanged update;
  final bool isLoading;
  final bool isSelectedAll;
  final int languageIndex;
  final void Function() changeFloating;
  final void Function() resetFloating;
  final void Function() changeFloatingActive;
  final void Function() activateFloatingDelete;
  final void Function() activateSelectAll;
  final void Function() resetSelectAll;
  @override
  State<WeightListView> createState() => WeightListViewState();
}

class WeightListViewState extends State<WeightListView>
    with ProjectStrings, ProjectPaddings, ProjectIcons, TickerProviderStateMixin {
  HashSet<UserWeight> selectedItems = HashSet();
  bool isMultiSelectionEnable = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero + EdgeInsets.only(top: paddingLight),
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
                    bool isSelected = selectedItems.contains(widget.data[index]);
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
      if (selectedItems.contains(userWeight)) {
        selectedItems.remove(userWeight);
        widget.resetSelectAll();
        if (selectedItems.isEmpty) {
          widget.changeFloatingActive();
          widget.resetSelectAll();
        }
      } else {
        widget.activateFloatingDelete();
        selectedItems.add(userWeight);
        if (widget.data.length == selectedItems.length) {
          widget.activateSelectAll();
        }
      }
      setState(() {});
    } else {
      // EDIT KISMI BURADA GERÇEKLEŞECEK
    }
  }

  void removeDataItem(int index, List<UserWeight> data, ValueChanged update) {
    return setState(() {
      data.removeAt(index);
      update(true);
    });
  }

  Future<void> deleteSelectedItems() async {
    for (var element in selectedItems) {
      await Future.delayed(const Duration(milliseconds: 200));
      widget.data.remove(element);
      widget.update(true);
    }
    widget.changeFloating();
    selectedItems.clear();
    isMultiSelectionEnable = false;
    setState(() {});
  }

  void resetSelectedItems() {
    widget.resetFloating();
    widget.resetSelectAll();
    selectedItems.clear();
    isMultiSelectionEnable = false;
    setState(() {});
  }

  // SELECT ALL KISMI

  void checkSelectAll() {
    if (!widget.isSelectedAll) {
      selectAllItems();
    } else {
      unSelectAllItems();
    }
  }

  void selectAllItems() {
    if (selectedItems.length != widget.data.length) {
      for (var element in widget.data) {
        if (!selectedItems.contains(element)) {
          selectedItems.add(element);
        }
      }
      widget.activateFloatingDelete();
      widget.activateSelectAll();
      setState(() {});
    } else {
      unSelectAllItems();
    }
  }

  void unSelectAllItems() {
    selectedItems.clear();
    widget.resetSelectAll();
    widget.changeFloatingActive();
    setState(() {});
  }
}
