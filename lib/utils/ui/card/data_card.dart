import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_paddings.dart';
import 'package:weight_track_app/utils/ui/text/subtitle_text.dart';

import '../../../constants/project_radius.dart';
import '../../../constants/project_strings.dart';
import '../text/title_text.dart';

class WeightDataCard extends StatelessWidget with ProjectRadius, ProjectStrings, ProjectPaddings {
  WeightDataCard(
      {super.key, required this.languageIndex, this.currentData, this.changeData, this.weeklyData, this.monthlyData});
  final int languageIndex;
  final double? currentData;
  final double? changeData;
  final double? weeklyData;
  final double? monthlyData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingHorizontalNormal,
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLow)),
          child: Column(children: [
            Padding(
                padding: paddingVerticalNormal + paddingTopNormal,
                child: _DataRow(children: [
                  _CardWeightColumn(findString(languageIndex, LanguagesEnum.current), currentData),
                  _CardWeightColumn(findString(languageIndex, LanguagesEnum.change), changeData),
                ])),
            Padding(
                padding: paddingVerticalNormal + paddingBottomNormal,
                child: _DataRow(children: [
                  _CardWeightColumn(findString(languageIndex, LanguagesEnum.weekly), weeklyData),
                  _CardWeightColumn(findString(languageIndex, LanguagesEnum.monthly), monthlyData),
                ])),
          ])),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children);
  }
}

class _CardWeightColumn extends StatelessWidget {
  const _CardWeightColumn(this.title, this.weightData);
  final String? title;
  final double? weightData;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        CustomSubTitleText(text: title ?? '-'),
        CustomTitleText(text: weightData == null ? '-' : '${weightData!.toStringAsFixed(1)}kg')
      ]),
    );
  }
}
