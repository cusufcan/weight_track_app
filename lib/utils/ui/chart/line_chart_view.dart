import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_track_app/constants/project_strings.dart';
import 'package:weight_track_app/modules/home/home_model.dart';

class LineChartView extends StatefulWidget {
  const LineChartView({super.key, required this.data, required this.languageIndex});
  final List<UserWeight> data;
  final int languageIndex;
  @override
  State<LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<LineChartView> {
  List<UserWeight> visibleData = [];
  void initVisibleData() {
    for (var element in widget.data) {
      if (element.date.year == widget.data.first.date.year) visibleData.add(element);
    }
  }

  @override
  void initState() {
    super.initState();
    initVisibleData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      child: widget.data.isEmpty
          ? Center(child: Text(ProjectStrings().findString(widget.languageIndex, LanguagesEnum.emptyData)))
          : SfCartesianChart(
              zoomPanBehavior: ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, enablePanning: true),
              primaryXAxis: DateTimeCategoryAxis(
                isInversed: true,
                minimum: DateTime(visibleData.first.date.year + 1, 1, 0),
                maximum: visibleData.last.date,
                dateFormat: DateFormat('dd/MM'),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<UserWeight, DateTime>>[
                StackedLineSeries<UserWeight, DateTime>(
                  animationDuration: 0,
                  markerSettings: const MarkerSettings(isVisible: true),
                  name: ProjectStrings().findString(widget.languageIndex, LanguagesEnum.chartName),
                  dataSource: visibleData,
                  xValueMapper: (UserWeight data, _) => data.date,
                  yValueMapper: (UserWeight data, _) => data.weight,
                )
              ],
            ),
    );
  }
}
