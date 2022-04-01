import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wakeup/models/alarm_record.dart';

import '../utils/firebase_database.dart';
import 'controller_main.dart';

class RecordController extends GetxController {
  var showDate = DateTime.now();  // 보여줄 날짜 (년,월)
  var showItems;

  FirebaseDataBase dataBase = Get.find<MainController>().dataBase;

  @override
  void onInit() async {
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
    for (AlarmRecord row in dataBase.recordList) {

    }

    list.sort((a, b){
      return b.start.compareTo(a.start);
    });

    return list;
  }
}