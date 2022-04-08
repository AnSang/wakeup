import 'package:get/get.dart';
import 'package:wakeup/ui/screen_clock.dart';
import 'package:wakeup/ui/screen_info.dart';
import 'package:wakeup/ui/screen_record.dart';
import 'package:wakeup/ui/screen_record2.dart';
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
  bool isShowProgress = false;

  @override
  void onInit() async {
    setShowProgress(true);
    await noti.initNotiSetting();
    await dataBase.getAlarmList().then((value) {
      for (AlarmInfo row in dataBase.alarmList) {
        if (row.isRun) {    /// 실행하기로 되어있는지 체크
          noti.dailyAtTimeNotification(row);
        }
      }
    });
    await dataBase.getInfo();       // UserInfoLocal
    await dataBase.downloadFile();
    setShowProgress(false);
    update();
    super.onInit();
  }

  void setScreen(int index) {
    showScreenIndex = index;
    update();
  }

  /// progress Indicator ON & OFF
  void setShowProgress(bool show) {
    isShowProgress = show;
    update();
  }
}