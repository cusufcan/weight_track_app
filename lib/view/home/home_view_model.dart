import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:weight_track_app/core/cache/shared_manager.dart';
import 'package:weight_track_app/core/constant/project_strings.dart';
import 'package:weight_track_app/view/home/home_model.dart';
import 'package:weight_track_app/view/home/home_view.dart';

abstract class HomeViewModel extends State<HomeView> with TickerProviderStateMixin, ProjectStrings {
  // Language
  int? languageIndex;

  // SharedManager
  late final SharedManager _manager;

  // Values
  late final String hintText;

  // Animation
  late final animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

  // DateTime
  DateTime selectedDate = DateTime.now();

  // Data
  List<UserWeight> dataList = [];
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

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  // Cache
  Future<void> _initialize() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId('83212382-451b-4943-960f-11b9c2360670');
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      if (kDebugMode) print('Accepted permission: $accepted');
    });

    _manager = SharedManager();
    await _manager.init();
    if (kDebugMode) print("First login: ${await _manager.checkFirstLogin()}");

    _getValues();
    animationController.addStatusListener(_updateStatus);
    _initLateValues();
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  void initLocalization() {
    final String language = Platform.localeName;
    language == 'tr_TR' ? languageIndex = 1 : languageIndex = 0;
  }

  void _initLateValues() {
    hintText = findString(languageIndex ?? 0, LanguagesEnum.zero);
  }

  Future<void> _getValues() async {
    _changeLoading();
    dateList = _manager.getStringItems(SharedKeys.dates) ?? [];
    weightList = _manager.getStringItems(SharedKeys.weights) ?? [];
    for (var i = 0; i < dateList.length; i++) {
      setState(() => dataList.add(UserWeight(date: DateTime.parse(dateList[i]), weight: double.parse(weightList[i]))));
    }
    _updateCardData();
    _changeLoading();
  }

  Future<void> saveValues() async {
    dateList = [];
    weightList = [];
    for (var data in dataList) {
      dateList.add(data.date.toString());
      weightList.add(data.weight.toString());
    }
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
    dataList.isNotEmpty ? currentData = dataList[0].weight : currentData = null;
    if (dataList.length > 1) {
      changeData = (currentData ?? 0) - dataList[1].weight;
      DateTime currentDate = dataList[0].date;

      // Calculate Weekly Change
      DateTime lastWeekDate = currentDate.subtract(const Duration(days: 7));
      bool isExactDateWeek = isDateExist(lastWeekDate);
      if (isExactDateWeek) {
        weeklyData = (currentData ?? 0) - dataList[checkIndex].weight;
      } else {
        int a = 0;
        while (!isExactDateWeek) {
          if (a == 6) break;
          isExactDateWeek = isDateExist(lastWeekDate);
          lastWeekDate = lastWeekDate.subtract(const Duration(days: 1));
          a++;
        }
        isExactDateWeek ? weeklyData = (currentData ?? 0) - dataList[checkIndex].weight : weeklyData = null;
      }
      // Calculate Monthly Change
      DateTime lastMonthDate = currentDate.copyWith(month: currentDate.month - 1);
      bool isExactDateMonth = isDateExist(lastMonthDate);
      if (isExactDateMonth) {
        monthlyData = (currentData ?? 0) - dataList[checkIndex].weight;
      } else {
        int a = 0;
        while (!isExactDateMonth) {
          if (a == 29) break;
          isExactDateMonth = isDateExist(lastMonthDate);
          lastMonthDate = lastMonthDate.subtract(const Duration(days: 1));
          a++;
        }
        isExactDateMonth ? monthlyData = (currentData ?? 0) - dataList[checkIndex].weight : monthlyData = null;
      }
    } else {
      changeData = null;
      weeklyData = null;
      monthlyData = null;
    }
  }

  bool isDateExist(DateTime lastDate) {
    checkIndex = 0;
    for (var data in dataList) {
      if (isDatesEqual(lastDate, data.date)) {
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
      for (var data in dataList) {
        if (selectedDate.year == data.date.year &&
            selectedDate.month == data.date.month &&
            selectedDate.day == data.date.day) {
          contains = true;
          break;
        }
      }
      // Adds new value to list.
      if (!contains) {
        dataList.add(UserWeight(date: selectedDate, weight: weight));
        dataList.sort((a, b) => b.date.compareTo(a.date));
        updateCardData();
        Navigator.pop(context);
        saveValues();
      } else {
        shake();
      }
    });
  }
}
