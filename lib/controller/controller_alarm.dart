import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeup/controller/controller_main.dart';
import 'dart:convert';
import 'package:wakeup/models/alarm_info.dart';

import '../main.dart';
import '../utils/firebase_database.dart';

class AlarmController extends GetxController {
  static const key = 'alarm';

  FirebaseDataBase dataBase = Get.find<MainController>().dataBase;

  late TimeOfDay timeOfDay;
  var alarmList;
  var daySelect = List.filled(7, false);
  var isAlarmCreate = false;
  var isAlarmModify = -1;
  var alarmTimeString = '';
  var alarmTime = DateTime.now();

  late User? loginInfo;

  @override
  void onInit() {
    loginInfo = FirebaseAuth.instance.currentUser;
    timeOfDay = TimeOfDay(hour: 12, minute: 00);
    alarmList = dataBase.alarmList;
    // alarmList = setAlarmList();
    daySelect = List.filled(7, false);
    super.onInit();
  }

  void mModify(int index) { // 알람 수정화면 띄우기
    isAlarmCreate = true;
    isAlarmModify = index;
    timeOfDay = TimeOfDay(hour: int.parse(alarmList[index].time.split(':')[0]), minute: int.parse(alarmList[index].time.split(':')[1]));
    daySelect = alarmList[index].day.cast<bool>();
    update();
  }

  void mSave(int index) { // 알람 수정화면 > 등록
    String time = timeOfDay.toString().substring(10,15);
    alarmList[index] = (AlarmInfo(index: index, time: time, day: daySelect.toList(), isRun: true));
    pref.setString(key, jsonEncode(alarmList));

    // init
    isAlarmCreate = false;
    isAlarmModify = -1;
    initTimeOfDay();
    initDaySelect();
    update();
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
    alarmList.add(AlarmInfo(index: alarmList.length, time: alarmTimeString, day: daySelect.toList(), isRun: true));
    pref.setString(key, jsonEncode(alarmList));
    update();
  }
////////////// delete /////////////////////
  void delAlarm(int index) {
    alarmList.removeAt(index);
    for (int i = 0; i < alarmList.length; i++) {  // 인덱스 재정렬
      alarmList[i].index = i;
    }

    pref.setString(key, jsonEncode(alarmList));
    update();
  }
////////////// Get /////////////////////
  String getDays(int index) {
    String day = '';
    for (int i = 0; i < alarmList[index].day.length; i++) {
      if (alarmList[index].day[i]) {
        if (i == 0) day += '일 ';
        else if (i == 1) day += '월 ';
        else if (i == 2) day += '화 ';
        else if (i == 3) day += '수 ';
        else if (i == 4) day += '목 ';
        else if (i == 5) day += '금 ';
        else if (i == 6) day += '토 ';
      }
    }
    return day;
  }

////////////// Set /////////////////////
  void setIsCreate(bool bool) {
    isAlarmCreate = bool;
    update();
  }

  void setBool(int index) {
    alarmList[index].isRun = !alarmList[index].isRun;
    pref.setString(key, jsonEncode(alarmList));
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

  /*void setInstance() {
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
  }*/
}