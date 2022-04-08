import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wakeup/ui/screen_login.dart';
import 'package:wakeup/ui/screen_main.dart';

import 'controller/controller_screen.dart';

final ScreenController controller = Get.put(ScreenController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();

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
      home: const Authentication(),
    );
  }
}

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return ScreenLogin();
        } else {
          return ScreenMain();
        }
      }
    );
  }
}

Future initFireBase() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  } else if (Platform.isIOS) {
    await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //     apiKey: 'AIzaSyC1U5zudqsAz8iSTt7t50mOKs4D42oWWPw',
    //     appId: 'com.example.wakeup_web',  // com.example.self_check <- 로 지정하면 Android App Name과 같아서 에러 나타남
    //     projectId: 'self-check-952f6',
    //     messagingSenderId: 'Sender_Ansang'
    // )
    //Todo : messagingSenderId 의 기능 파악하기
    );
  } else {

  }
}
