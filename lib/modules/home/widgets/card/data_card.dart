import 'package:flutter/material.dart';

import '../../../../constants/project_radius.dart';
import '../../../../constants/project_strings.dart';
import '../../pages/home_view.dart';

class WeightDataCard extends StatelessWidget with ProjectRadius, ProjectStrings {
  WeightDataCard({super.key, required this.languageIndex});
  final int languageIndex;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLow)),
        child: Column(children: [
          WeightRow(isTop: true, children: [
            CardWeightColumn(title: findString(languageIndex, LanguagesEnum.current), weightData: 0),
            CardWeightColumn(title: findString(languageIndex, LanguagesEnum.change), weightData: 0),
          ]),
          const Divider(),
          WeightRow(isTop: false, children: [
            CardWeightColumn(title: findString(languageIndex, LanguagesEnum.weekly), weightData: 0),
            CardWeightColumn(title: findString(languageIndex, LanguagesEnum.monthly), weightData: 0),
          ]),
        ]));
  }
}
