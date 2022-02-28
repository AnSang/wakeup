import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeup/controller/controller_main.dart';

final MainController controller = Get.put(MainController());

class ScreenMain extends StatelessWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Text('This is Main Screen');
        }
    );
  }
}