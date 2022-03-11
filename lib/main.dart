import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeup/ui/screen_login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'controller/controller_screen.dart';

final ScreenController controller = Get.put(ScreenController());
late SharedPreferences pref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC1U5zudqsAz8iSTt7t50mOKs4D42oWWPw',
          appId: 'com.example.wakeup_web',  // com.example.self_check <- 로 지정하면 Android App Name과 같아서 에러 나타남
          projectId: 'self-check-952f6',
          messagingSenderId: 'Sender_Ansang'
      )
    //Todo : messagingSenderId 의 기능 파악하기
  );

  runApp(const ScreenManage());
}

class ScreenManage extends StatelessWidget {
  const ScreenManage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WakeUp Alarm',
      color: Colors.black,
      home: const ScreenLogin(),
    );
  }
}