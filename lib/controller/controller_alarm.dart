import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:wakeup/models/alarm_info.dart';

import '../main.dart';

class AlarmController extends GetxController {
  static const key = 'alarm';

  late TimeOfDay timeOfDay;
  late List<AlarmInfo> alarmList;
  late List<bool> daySelect;
  var isAlarmCreate = false;

  @override
  void onInit() {
    timeOfDay = TimeOfDay(hour: 12, minute: 00);
    alarmList = setAlarmList();
    daySelect = List.filled(7, false);
    super.onInit();
  }

/////////////// init /////////////////////
  void initTimeOfDay() {
    timeOfDay = TimeOfDay(hour: 12, minute: 00);
    update();
  }

  void initDaySelect() {
    daySelect.fillRange(0, daySelect.length, false);
    update();
  }
////////////// add /////////////////////
  void addAlarm() {
    alarmList.add(AlarmInfo(time: timeOfDay.toString(), day: daySelect, isRun: true));
    pref.setString(key, jsonEncode(alarmList));
    update();
  }

////////////// Set /////////////////////
  void setIsCreate(bool bool) {
    isAlarmCreate = bool;
    update();
  }

  void setBool(int index) {
    alarmList[index].isRun = !alarmList[index].isRun;
    update();
  }

  void setTimeOfDay(TimeOfDay time) {
    timeOfDay = time;
    update();
  }

  void setDaySelectItem(int index, int day) {
    alarmList[index].day[day] = !alarmList[index].day[day];
    update();
  }

  void setDaySelect(int index) {
    daySelect[index] = !daySelect[index];
    update();
  }

  List<AlarmInfo> setAlarmList() {
    String? list = pref.getString(key);
    if (list == null) {
      return [];
    } else {
      List<AlarmInfo> list_ = [];
      List copy = jsonDecode(list);
      for (Map<String, Object?> row in copy) {
        list_.add(AlarmInfo.fromJson(row));
      }
      return list_;
    }
  }

  void setInstance() {
    alarmList.clear();
    alarmList.add(AlarmInfo(time: '14:42', day: List.filled(7, false), isRun: false));
    alarmList.add(AlarmInfo(time: '06:11', day: List.filled(7, true), isRun: true));
    alarmList.add(AlarmInfo(time: '09:42', day: List.filled(7, false), isRun: false));
    alarmList.add(AlarmInfo(time: '14:42', day: List.filled(7, false), isRun: false));
    alarmList.add(AlarmInfo(time: '14:42', day: List.filled(7, true), isRun: false));
    alarmList.add(AlarmInfo(time: '06:11', day: List.filled(7, false), isRun: true));
    alarmList.add(AlarmInfo(time: '09:42', day: List.filled(7, false), isRun: false));
    alarmList.add(AlarmInfo(time: '14:42', day: List.filled(7, false), isRun: false));
    update();
  }
}