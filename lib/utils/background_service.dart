import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:wakeup/models/alarm_info.dart';
import 'package:wakeup/models/user_info.dart';
import 'package:wakeup/utils/firebase_database.dart';
import 'package:wakeup/utils/notification.dart';

class BackGroundService {
  final FlutterBackgroundService service = FlutterBackgroundService();

  Future<void> initializeService() async {
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  }
}

bool onIosBackground(ServiceInstance service) {
  print('FLUTTER BACKGROUND FETCH');
  return true;
}

Future onStart(ServiceInstance service) async {
  await Firebase.initializeApp();
  final AlarmNotification noti = AlarmNotification();
  final FirebaseDataBase dataBase = FirebaseDataBase();
  noti.initNotiSetting();

  if (service is AndroidServiceInstance) {
    // service.setAsForegroundService();
    service.setAsBackgroundService();
  }

  /// 처리할 함수들 여기 작성
  Timer.periodic(const Duration(hours: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "알람 프로그램 실행중",
        content: "알람 컨텐츠",
      );
    }

    await noti.deleteAllAlarm(); // 알람 전체 삭제
    UserInfoLocal info = await dataBase.getInfo();
    List<AlarmInfo> _list = await dataBase.getAlarmList();

    for (AlarmInfo alarm in _list) {
      if (alarm.isRun) {
        noti.dailyAtTimeNotification(alarm, info.sound);
      }
    }
  });
}