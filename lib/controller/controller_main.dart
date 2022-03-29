import 'package:get/get.dart';
import 'package:wakeup/ui/screen_clock.dart';
import 'package:wakeup/ui/screen_info.dart';
import 'package:wakeup/ui/screen_record.dart';
import 'package:wakeup/utils/firebase_database.dart';
import 'package:wakeup/utils/notification.dart';

import '../models/alarm_info.dart';
import '../ui/screen_alarm.dart';

class MainController extends GetxController {
  static const key = 'Main';
  List screens = [ ScreenClock(), ScreenAlarm(), ScreenRecord(), ScreenInfo() ]; // Screen List

  final FirebaseDataBase dataBase = FirebaseDataBase();
  final AlarmNotification noti = AlarmNotification();

  var showScreenIndex = 0;            // Screen List, Menu List   Index


  @override
  void onInit() async {
    noti.initNotiSetting();
    dataBase.getAlarmList().then((value) {
      for (AlarmInfo row in dataBase.alarmList) {
        if (row.isRun) {
          // if (row.isRun && row.day[DateTime.now().weekday - 1]) {    /// 실행하기로 되어있는지 체크
          noti.dailyAtTimeNotification(row);
        }
      }
    });
    super.onInit();
  }

  void setScreen(int index) {
    showScreenIndex = index;
    update();
  }
}