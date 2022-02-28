import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wakeup/ui/screen_login.dart';

import 'controller/controller_screen.dart';

final ScreenController controller = Get.put(ScreenController());

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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