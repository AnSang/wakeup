import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ClockController extends GetxController {
  var now = DateTime.now();
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  var formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());
  var timezoneString = DateTime.now().timeZoneOffset.toString().split('.').first;
  var offsetSign = '+';

  @override
  void onInit() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      now = DateTime.now();
      formattedTime = DateFormat('HH:mm').format(now);
      formattedDate = DateFormat('EEE, d MMM').format(now);
      timezoneString = now.timeZoneOffset.toString().split('.').first;
      if (!timezoneString.startsWith('-')) offsetSign = '+';
      update();
    });
    super.onInit();
  }
}