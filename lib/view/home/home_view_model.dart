import 'package:flutter/material.dart';
import 'package:weight_track_app/core/cache/shared_manager.dart';
import 'package:weight_track_app/core/constant/project_strings.dart';
import 'package:weight_track_app/view/home/home_view.dart';

abstract class HomeViewModel extends State<HomeView> with TickerProviderStateMixin, ProjectStrings {
  late final SharedManager _manager;

  late final String hintText = zero;

  // Animation
  late final animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

  DateTime selectedDate = DateTime.now();

  // Data
  Map<DateTime, double> data = {};
  List<String> dateList = [];
  List<String> weightList = [];
  int checkIndex = 0;
  double? currentData;
  double? changeData;
  double? weeklyData;
  double? monthlyData;

  // Controller
  bool isOkBtnActive = false;
  bool isLoading = false;
  final weightFormFieldController = TextEditingController();
  final weightSemiFormFieldController = TextEditingController();

  // Page
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _manager = SharedManager();
    _initialize();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  // Cache
  Future<void> _initialize() async {
    await _manager.init();
    _getValues();
  }

  Future<void> _getValues() async {
    _changeLoading();
    dateList = _manager.getStringItems(SharedKeys.dates) ?? [];
    weightList = _manager.getStringItems(SharedKeys.weights) ?? [];
    for (var i = 0; i < dateList.length; i++) {
      setState(() => data[DateTime.parse(dateList[i])] = double.parse(weightList[i]));
    }
    _updateCardData();
    _changeLoading();
  }

  Future<void> saveValues() async {
    dateList = [];
    weightList = [];
    data.forEach((date, weight) {
      dateList.add(date.toString());
      weightList.add(weight.toString());
    });
    await _manager.saveStringItems(SharedKeys.dates, dateList);
    await _manager.saveStringItems(SharedKeys.weights, weightList);
  }

  // Animation
  void _updateStatus(AnimationStatus status) {
    status == AnimationStatus.completed ? animationController.reset() : null;
  }

  void _changeLoading() {
    isLoading = !isLoading;
  }

  void shake() {
    animationController.forward();
  }

  // Controller
  void checkIsTextHere(StateSetter setState) {
    weightFormFieldController.text.isEmpty
        ? setState(() => isOkBtnActive = false)
        : setState(() => isOkBtnActive = true);
  }

  // DATA
  void updateCardData() {
    setState(() => _updateCardData());
    saveValues();
  }

  void _updateCardData() {
    data.isNotEmpty ? currentData = data.values.elementAt(0) : currentData = null;
    if (data.length > 1) {
      changeData = (currentData ?? 0) - data.values.elementAt(1);
      DateTime currentDate = data.keys.elementAt(0);

      // Calculate Weekly Change
      DateTime lastWeekDate = currentDate.subtract(const Duration(days: 7));
      bool isExactDateWeek = isDateExist(lastWeekDate);
      if (isExactDateWeek) {
        weeklyData = (currentData ?? 0) - data.values.elementAt(checkIndex);
      } else {
        int a = 0;
        while (!isExactDateWeek) {
          if (a == 6) break;
          isExactDateWeek = isDateExist(lastWeekDate);
          lastWeekDate = lastWeekDate.subtract(const Duration(days: 1));
          a++;
        }
        isExactDateWeek ? weeklyData = (currentData ?? 0) - data.values.elementAt(checkIndex) : weeklyData = null;
      }
      // Calculate Monthly Change
      DateTime lastMonthDate = currentDate.copyWith(month: currentDate.month - 1);
      bool isExactDateMonth = isDateExist(lastMonthDate);
      if (isExactDateMonth) {
        monthlyData = (currentData ?? 0) - data.values.elementAt(checkIndex);
      } else {
        int a = 0;
        while (!isExactDateMonth) {
          if (a == 29) break;
          isExactDateMonth = isDateExist(lastMonthDate);
          lastMonthDate = lastMonthDate.subtract(const Duration(days: 1));
          a++;
        }
        isExactDateMonth ? monthlyData = (currentData ?? 0) - data.values.elementAt(checkIndex) : monthlyData = null;
      }
    } else {
      changeData = null;
      weeklyData = null;
      monthlyData = null;
    }
  }

  bool isDateExist(DateTime lastDate) {
    checkIndex = 0;
    for (var date in data.keys) {
      if (isDatesEqual(lastDate, date)) {
        return true;
      } else {
        checkIndex++;
      }
    }
    return false;
  }

  bool isDatesEqual(DateTime lastDate, DateTime key) {
    return key.year == lastDate.year && key.month == lastDate.month && key.day == lastDate.day;
  }

  void applyWeight() {
    final String weightString = '${weightFormFieldController.text}.${weightSemiFormFieldController.text}';
    final double weight = double.parse(weightString);
    setState(() {
      // Checks if data is here already.
      bool contains = false;
      for (var date in data.keys) {
        if (selectedDate.year == date.year && selectedDate.month == date.month && selectedDate.day == date.day) {
          contains = true;
          break;
        }
      }
      // Adds new value to list.
      if (!contains) {
        data[selectedDate] = weight;
        data = Map.fromEntries(data.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));
        updateCardData();
        Navigator.pop(context);
        saveValues();
      } else {
        shake();
      }
    });
  }
}
