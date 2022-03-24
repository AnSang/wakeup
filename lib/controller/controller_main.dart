import 'package:get/get.dart';
import 'package:wakeup/ui/screen_clock.dart';
import 'package:wakeup/ui/screen_info.dart';
import 'package:wakeup/ui/screen_record.dart';
import 'package:wakeup/utils/firebase_database.dart';

import '../ui/screen_alarm.dart';

class MainController extends GetxController {
  static const key = 'Main';
  List screens = [ ScreenClock(), ScreenAlarm(), ScreenRecord(), ScreenInfo() ]; // Screen List
  FirebaseDataBase dataBase = FirebaseDataBase();

  var showScreenIndex = 0;            // Screen List, Menu List   Index


  @override
  void onInit() async {
    dataBase.getAlarmList();
    super.onInit();
  }

  void setScreen(int index) {
    showScreenIndex = index;
    update();
  }
}