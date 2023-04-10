import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_track_app/core/constant/project_strings.dart';
import 'package:weight_track_app/view/home/home_model.dart';

class LineChartView extends StatefulWidget {
  const LineChartView({super.key, required this.data, required this.languageIndex});
  final List<UserWeight> data;
  final int languageIndex;
  @override
  State<LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<LineChartView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      child: widget.data.isEmpty
          ? Center(child: Text(ProjectStrings().findString(widget.languageIndex, LanguagesEnum.emptyData)))
          : SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: DateTimeAxis(
                minimum: widget.data.first.date.copyWith(day: 1),
                maximum: DateTime.now(),
                intervalType: DateTimeIntervalType.days,
                dateFormat: DateFormat.yMd(),
                rangePadding: ChartRangePadding.normal,
              ),
              primaryYAxis: NumericAxis(),
              series: <ChartSeries>[
                StackedLineSeries<UserWeight, DateTime>(
                  animationDuration: 0,
                  markerSettings: const MarkerSettings(isVisible: true),
                  name: ProjectStrings().findString(widget.languageIndex, LanguagesEnum.chartName),
                  dataSource: widget.data,
                  xValueMapper: (UserWeight data, _) => data.date,
                  yValueMapper: (UserWeight data, _) => data.weight,
                )
              ],
            ),
    );
  }
}
