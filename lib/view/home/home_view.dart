import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:weight_track_app/core/constant/project_colors.dart';
import 'package:weight_track_app/core/constant/project_icons.dart';
import 'package:weight_track_app/core/constant/project_paddings.dart';
import 'package:weight_track_app/core/constant/project_radius.dart';
import 'package:weight_track_app/core/constant/project_strings.dart';
import 'package:weight_track_app/core/error/shake_error.dart';
import 'package:weight_track_app/core/widget/button/elevated_button.dart';
import 'package:weight_track_app/core/widget/text/title_text.dart';
import 'package:weight_track_app/core/widget/textField/text_field.dart';
import 'package:weight_track_app/view/home/home_view_model.dart';

import '../../core/widget/listTile/weight_list_tile.dart';
import '../../core/widget/text/subtitle_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel with ProjectStrings, ProjectColors, ProjectIcons, ProjectPaddings {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName), actions: [
        Center(
            child: IconButton(
                tooltip: settings,
                icon: icSettings,
                onPressed: () {
                  // SONRA EKLENECEK
                  // Navigator.of(context).pushNamed(settings.toLowerCase());
                }))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          tooltip: addData,
          child: Icon(Icons.add_outlined, color: white),
          onPressed: () => _showCustomBottomSheet(context)),
      body: Padding(
          padding: EdgeInsets.only(top: paddingNormal),
          child: Column(children: [_showWeightDataCard(), Expanded(child: _showWeightListView())])),
    );
  }

  _WeightDataCard _showWeightDataCard() {
    return _WeightDataCard(
        currentData: currentData, changeData: changeData, weeklyData: weeklyData, monthlyData: monthlyData);
  }

  _WeightListView _showWeightListView() =>
      _WeightListView(data: data, update: (value) => updateCardData(), isLoading: isLoading);

  // Bottom Sheet
  Future<dynamic> _showCustomBottomSheet(BuildContext context) {
    isOkBtnActive = false;
    weightFormFieldController.text = empty;
    weightSemiFormFieldController.text = empty;
    selectedDate = DateTime.now();
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(ProjectRadius().radiusNormal))),
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
                padding: EdgeInsets.only(top: paddingNormal, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: _bottomSheetContent(setState));
          });
        });
  }

  Column _bottomSheetContent(StateSetter setState) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: paddingHorizontalVeryHigh + EdgeInsets.only(bottom: paddingHigh),
          child: CustomTitleText(text: addRecord)),
      Padding(
          padding: paddingHorizontalVeryHigh + EdgeInsets.only(bottom: paddingMed), child: _formFieldsRow(setState)),
      Padding(padding: EdgeInsets.only(bottom: paddingMed), child: _customScrollDatePicker(setState)),
      Padding(padding: paddingHorizontalVeryHigh + EdgeInsets.only(bottom: paddingMed), child: _buttonsRow())
    ]);
  }

  Row _formFieldsRow(StateSetter customSetState) {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Expanded(
          flex: 10,
          child: CustomFormField(
              controller: weightFormFieldController,
              onChanged: (text) => checkIsTextHere(customSetState),
              maxLength: 3,
              autoFocus: true,
              textInputAction: TextInputAction.next)),
      const Expanded(flex: 1, child: CustomTitleText(text: '.', textAlign: TextAlign.center)),
      Expanded(
          flex: 3,
          child: CustomFormField(
              controller: weightSemiFormFieldController,
              maxLength: 1,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              isZeroIn: true,
              labelText: '0'))
    ]);
  }

  ShakeError _customScrollDatePicker(StateSetter setState) {
    return ShakeError(
        animationController: animationController,
        shakeOffset: 5,
        shakeCount: 10,
        child: SizedBox(
            height: 100,
            child: ScrollDatePicker(
                selectedDate: selectedDate,
                onDateTimeChanged: (value) {
                  setState(() {
                    selectedDate = value;
                  });
                })));
  }

  Row _buttonsRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
      Expanded(flex: 3, child: CustomElevatedButton(onPressed: () => Navigator.pop(context), text: cancelUpper)),
      const Spacer(),
      Expanded(
          flex: 3,
          child: CustomElevatedButton(
              onPressed: isOkBtnActive ? applyWeight : null, text: isOkBtnActive ? okUpper : disable)),
    ]);
  }
}

// Weight Data Card
class _WeightDataCard extends StatelessWidget {
  const _WeightDataCard({this.currentData, this.changeData, this.weeklyData, this.monthlyData});
  final double? currentData;
  final double? changeData;
  final double? weeklyData;
  final double? monthlyData;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: ProjectPaddings().paddingHorizontalNormal + EdgeInsets.only(bottom: ProjectPaddings().paddingNormal),
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ProjectRadius().radiusLow)),
            child: Column(children: [
              _WeightRow(isTop: true, children: [
                _CardWeightColumn(title: ProjectStrings().current, weightData: currentData),
                _CardWeightColumn(title: ProjectStrings().change, weightData: changeData),
              ]),
              const Divider(),
              _WeightRow(isTop: false, children: [
                _CardWeightColumn(title: ProjectStrings().weekly, weightData: weeklyData),
                _CardWeightColumn(title: ProjectStrings().monthly, weightData: monthlyData),
              ]),
            ])));
  }
}

class _WeightRow extends StatelessWidget {
  const _WeightRow({required this.children, required this.isTop});
  final bool isTop;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: ProjectPaddings().paddingVerticalNormal + _isTop(), child: _weightRowChild());
  }

  EdgeInsets _isTop() {
    return (isTop
        ? EdgeInsets.only(top: ProjectPaddings().paddingNormal)
        : EdgeInsets.only(bottom: ProjectPaddings().paddingNormal));
  }

  Row _weightRowChild() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children);
  }
}

class _CardWeightColumn extends StatelessWidget {
  const _CardWeightColumn({this.weightData, this.title});
  final String? title;
  final double? weightData;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomSubTitleText(text: title ?? ProjectStrings().emptySign),
      CustomTitleText(text: weightData == null ? ProjectStrings().emptySign : '${weightData!.toStringAsFixed(1)}kg')
    ]);
  }
}

// ListView

class _WeightListView extends StatefulWidget {
  const _WeightListView({required this.data, required this.update, required this.isLoading});
  final Map data;
  final ValueChanged update;
  final bool isLoading;
  @override
  State<_WeightListView> createState() => _WeightListViewState();
}

class _WeightListViewState extends State<_WeightListView> with ProjectStrings, ProjectPaddings, ProjectIcons {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: widget.isLoading
            ? const Center(child: CircularProgressIndicator())
            : widget.data.isEmpty
                ? Center(child: Text(emptyData))
                : _showListView());
  }

  ListView _showListView() {
    return ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context, int index) {
          var valueKey = ValueKey<DateTime>(widget.data.keys.elementAt(index));
          return _showDismissibleListTile(valueKey, index);
        });
  }

  Dismissible _showDismissibleListTile(ValueKey<DateTime> valueKey, int index) {
    return Dismissible(
        direction: DismissDirection.startToEnd,
        dragStartBehavior: DragStartBehavior.start,
        background: _dismissibleContent(),
        key: valueKey,
        onDismissed: (direction) => removeDataItem(index, widget.data, widget.update),
        child: _showCustomListTile(index));
  }

  Container _dismissibleContent() {
    return Container(
        color: Colors.red,
        padding: paddingHorizontalNormal,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_deleteIcon()]));
  }

  WeightListTile _showCustomListTile(int index) =>
      WeightListTile(date: widget.data.keys.elementAt(index), weight: widget.data.values.elementAt(index));

  Icon _deleteIcon() => icDelete;

  void removeDataItem(int index, Map data, ValueChanged update) {
    return setState(() {
      data.remove(data.keys.elementAt(index));
      update(true);
    });
  }
}
