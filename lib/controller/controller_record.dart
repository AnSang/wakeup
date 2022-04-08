import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wakeup/models/alarm_record.dart';

import '../utils/firebase_database.dart';
import 'controller_main.dart';

class RecordController extends GetxController {
  DateTime showDate = DateTime.now();  // 보여줄 날짜 (년,월)
  List<AlarmRecord> recordList = [];
  List<DateTimeRange> showItems = [];
  AlarmRecord? toDay;
  bool check = false;
  bool btnStart = false;
  bool btnEnd = false;

  /*List<DateTimeRange> showItems = [
    DateTimeRange(start: DateTime(2022, 4, 25, 21, 43),end: DateTime(2022, 4, 26, 5, 42)),
    DateTimeRange(start: DateTime(2022, 4, 14, 11, 43),end: DateTime(2022, 4, 14, 15, 42)),
    DateTimeRange(start: DateTime(2022, 4, 13, 4, 53), end: DateTime(2022, 4, 13, 11, 22)),
    DateTimeRange(start: DateTime(2022, 4, 12, 6, 0), end: DateTime(2022, 4, 12, 14, 22)),
    DateTimeRange(start: DateTime(2022, 4, 11, 4, 53), end: DateTime(2022, 4, 11, 11, 53)),
    DateTimeRange(start: DateTime(2022, 4, 5, 13, 0), end: DateTime(2022, 4, 6, 1, 22)),
  ];*/


  FirebaseDataBase dataBase = Get.find<MainController>().dataBase;

  @override
  void onInit() async {
    String date = DateFormat('yyyy.M.d').format(DateTime.now());
    recordList = await dataBase.getRecordList(); // 기록 data 가져오기
    toDay = await dataBase.getRecordDate(date);
    setButtonBool();
    showItems = getMonthItem();
    check = true;
    update();
    super.onInit();
  }

  void plusMonth() {
    showDate = DateTime(showDate.year, showDate.month + 1);
    showItems.clear();
    showItems = getMonthItem();
    update();
  }

  void minMonth() {
    showDate = DateTime(showDate.year, showDate.month - 1);
    showItems.clear();
    showItems = getMonthItem();
    update();
  }

  Future startRecord() async {  // 수면 시작
    setShowProgress(true);
    DateTime now = DateTime.now();
    String date = '${now.year}.${now.month}.${now.day}';
    String time = '${now.hour}:${now.minute}';

    await dataBase.addRecord(date, time);
    toDay = AlarmRecord(sDate: date, sTime: time, eDate: null, eTime: null);
    setButtonBool();
    setShowProgress(false);
    update();
  }

  Future endRecord() async {  // 수면 종료
    setShowProgress(true);
    DateTime now = DateTime.now();
    String date = '${now.year}.${now.month}.${now.day}';
    String time = '${now.hour}:${now.minute}';

    await dataBase.updateRecord(date, time);
    toDay?.eDate = date;
    toDay?.eTime = time;
    setButtonBool();
    setShowProgress(false);
    update();
  }

  Future getDayRecord() async {
    DateTime now = DateTime.now();
    String date = '${now.year}.${now.month}.${now.day}';
    await dataBase.getRecordDate(date);
  }

  Stream<QuerySnapshot> getRecordReference() {
    return dataBase.getRecordReference();
  }

  /// progress Indicator ON & OFF
  void setShowProgress(bool show) {
    Get.find<MainController>().setShowProgress(show);
    update();
  }

  /// showDate convert to '2022.4'
  String getMonth(DateTime date) {
    return DateFormat('yyyy.M').format(date);
  }

  /// 수면시작, 수면종료 버튼 활성화
  void setButtonBool() {
    if (toDay == null) {  // 수면시작 전
      btnStart = true;
      btnEnd = false;
    } else if (toDay?.eDate == null) {  // 수면시작 후
      btnStart = false;
      btnEnd = true;
    } else {  // 하루의 기록 끝난경우
      btnStart = false;
      btnEnd = false;
    }
  }

  List<DateTimeRange> getMonthItem() {
    List<DateTimeRange> list = [];

    for (AlarmRecord row in recordList) {
      if (row.sDate.contains(getMonth(showDate)) && row.eDate != null && row.eTime != null) {
        List<String> _sDate = row.sDate.split('.');
        List<String> _sTime = row.sTime.split(':');
        List<String> _eDate = row.eDate!.split('.');
        List<String> _eTime = row.eTime!.split(':');

        DateTime start = DateTime(int.parse(_sDate[0]), int.parse(_sDate[1]), int.parse(_sDate[2]), int.parse(_sTime.first), int.parse(_sTime.last));
        DateTime end = DateTime(int.parse(_eDate[0]), int.parse(_eDate[1]), int.parse(_eDate[2]), int.parse(_eTime.first), int.parse(_eTime.last));
        list.add(DateTimeRange(start: start, end: end));
      }
    }

    list.sort((a, b) => b.start.compareTo(a.start));

    return list;
  }
}