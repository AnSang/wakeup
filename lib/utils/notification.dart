import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPlugin {
  BuildContext context;
  var flutterLocalNotificationsPlugin;

  NotificationPlugin({required this.context});

  void initNotification() {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future<void> onSelectNotification(String payload) async {
    debugPrint(payload);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Notification Payload'),
          content: Text('Payload: $payload'),
        ));
  }

  Future<void> dailyAtTimeNotification() async {
    var time = Time(09, 32, 30);
    var android = AndroidNotificationDetails(
        '알람앱 ID', '알람앱 NAME', channelDescription: '알람앱 description',
        importance: Importance.max, priority: Priority.high);

    var ios = IOSNotificationDetails();
    var detail = NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      '${time.hour}시 ${time.minute}분',
      '하단 표시글',
      time,
      detail,
      payload: 'Hello Flutter',
    );
  }

  Future<void> repeatNotification() async {
    var android = AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription: 'your channel description',
        importance: Importance.max, priority: Priority.high);

    var ios = IOSNotificationDetails();
    var detail = NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '반복 Notification',
      '반복 Notification 내용',
      RepeatInterval.everyMinute,
      detail,
      payload: 'Hello Flutter',
    );
  }
}
