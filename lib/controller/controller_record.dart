import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wakeup/models/alarm_record.dart';

class RecordController extends GetxController {
  var showDate = DateTime.now();  // 보여줄 날짜 (년,월)
  var showItems;
  List<AlarmRecord> items = [];

  @override
  void onInit() async {
    items = instance();
    showItems = getMonthItem();
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

  String getMonth(DateTime date) {
    return DateFormat('yyyy.MM').format(date);
  }

  List<DateTimeRange> getMonthItem() {
    List<DateTimeRange> list = [];
    for (AlarmRecord row in items) {
      String rowMonth = getMonth(row.start);
      String nowMonth = getMonth(showDate);
      if (rowMonth.contains(nowMonth)) {
        list.add(DateTimeRange(start: row.start, end: row.end));
      }
    }

    list.sort((a, b){
      return b.start.compareTo(a.start);
    });

    return list;
  }

  List<AlarmRecord> instance() {
    List<AlarmRecord> list = [];
    list.add(AlarmRecord(start: DateTime(2022, 3, 12, 6, 0), end: DateTime(2022, 3, 12, 14, 22), count: 2));
    list.add(AlarmRecord(start: DateTime(2022, 3, 13, 4, 53), end: DateTime(2022, 3, 13, 11, 53), count: 1));
    list.add(AlarmRecord(start: DateTime(2022, 3, 14, 11, 43),end: DateTime(2022, 3, 14, 15, 42), count: 1));

    list.add(AlarmRecord(start: DateTime(2022, 4, 5, 13, 0), end: DateTime(2022, 4, 6, 1, 22), count: 2));
    list.add(AlarmRecord(start: DateTime(2022, 4, 13, 4, 53), end: DateTime(2022, 4, 13, 11, 22), count: 1));
    list.add(AlarmRecord(start: DateTime(2022, 4, 25, 21, 43),end: DateTime(2022, 4, 26, 5, 42), count: 1));
    return list;
  }
}