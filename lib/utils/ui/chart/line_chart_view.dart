import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_track_app/constants/project_paddings.dart';
import 'package:weight_track_app/constants/project_strings.dart';

import '../../../pages/home/home_model.dart';

class LineChartView extends StatefulWidget {
  const LineChartView({super.key, required this.data, required this.languageIndex});
  final List<UserWeight> data;
  final int languageIndex;
  @override
  State<LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<LineChartView> with ProjectPaddings, ProjectStrings {
  List<UserWeight> visibleData = [];
  int activeBtn = 2;

  @override
  void initState() {
    super.initState();
    initVisibleData();
  }

  void initVisibleData() {
    for (var element in widget.data) {
      if (element.date.year == widget.data.first.date.year) visibleData.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonBar(alignment: MainAxisAlignment.spaceAround, children: _getButtons()),
        Expanded(
          child: Card(
            margin: EdgeInsets.zero + EdgeInsets.only(top: paddingLight),
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
            child: widget.data.isEmpty
                ? Center(child: Text(findString(widget.languageIndex, LanguagesEnum.emptyData)))
                : SfCartesianChart(
                    borderWidth: 0,
                    zoomPanBehavior: (widget.data.length > 5)
                        ? ZoomPanBehavior(
                            maximumZoomLevel: 0.2,
                            enablePinching: true,
                            zoomMode: ZoomMode.x,
                            enablePanning: true,
                          )
                        : null,
                    primaryXAxis: DateTimeCategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      labelPlacement: LabelPlacement.onTicks,
                      isInversed: true,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      dateFormat: DateFormat('dd/MM/yy'),
                    ),
                    primaryYAxis: NumericAxis(
                      isVisible: true,
                      maximum: _calculateMaxValue,
                      minimum: _calculateMinValue,
                      desiredIntervals: _calculateListCost,
                      numberFormat: NumberFormat('0'),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true, duration: 1300, animationDuration: 200),
                    series: <ChartSeries<UserWeight, DateTime>>[
                      StackedLineSeries<UserWeight, DateTime>(
                        animationDuration: 0,
                        markerSettings: const MarkerSettings(isVisible: true),
                        dataSource: visibleData,
                        name: "",
                        xValueMapper: (UserWeight data, _) => data.date,
                        yValueMapper: (UserWeight data, _) => data.weight,
                      )
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  List<ElevatedButton> _getButtons() {
    List<ElevatedButton> list = [
      _periodButton(0, LanguagesEnum.graphW),
      _periodButton(1, LanguagesEnum.graphM),
      _periodButton(2, LanguagesEnum.graph1Y),
      _periodButton(3, LanguagesEnum.graph5Y),
    ];
    return list;
  }

  ElevatedButton _periodButton(int idx, LanguagesEnum textKey) {
    return ElevatedButton(
      onPressed: () => _changeGraphPeriod(idx),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor:
            activeBtn == idx ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
      ),
      child: Text(findString(widget.languageIndex, textKey)),
    );
  }

  void _changeGraphPeriod(int idx) {
    setState(() {});
    if (activeBtn != idx) {
      activeBtn = idx;
      visibleData = [];
      switch (idx) {
        case 0:
          if (widget.data.length >= 7) {
            for (int i = 0; i < 7; i++) {
              var tempData = widget.data[i];
              secondfor:
              for (int j = 0; j < 7; j++) {
                var checkData = widget.data.first.date.subtract(Duration(days: j));
                if (checkData.year == tempData.date.year &&
                    checkData.month == tempData.date.month &&
                    checkData.day == tempData.date.day) {
                  visibleData.add(tempData);
                  break secondfor;
                }
              }
            }
          } else {
            visibleData = widget.data;
          }
          break;
        case 1:
          for (var element in widget.data) {
            if (widget.data.first.date.year == element.date.year) {
              if (widget.data.first.date.month == element.date.month) visibleData.add(element);
            }
          }
          break;
        case 2:
          initVisibleData();
          break;
        case 3:
          visibleData = widget.data;
          break;
        default:
      }
    }
  }

  double get _calculateMaxValue {
    List<double> temp = visibleData.map((e) => e.weight).toList();
    return visibleData.length == 1 ? temp.reduce(max) + 10 : temp.reduce(max);
  }

  double get _calculateMinValue {
    List<double> temp = visibleData.map((e) => e.weight).toList();
    return visibleData.length == 1 ? temp.reduce(min) - 10 : temp.reduce(min);
  }

  int get _calculateListCost {
    Set<double> tempData = visibleData.map((e) => e.weight).toList().toSet();
    return tempData.length % 2 == 0 ? tempData.length : tempData.length - 1;
  }
}
