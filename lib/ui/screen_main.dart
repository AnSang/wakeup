import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeup/controller/controller_main.dart';
import 'package:wakeup/strings.dart';

final MainController controller = Get.put(MainController());

class ScreenMain extends StatelessWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: controller.screens[controller.showScreenIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withOpacity(.40),
                selectedFontSize: 12,
                unselectedFontSize: 12,
                currentIndex: controller.showScreenIndex,
                onTap: (index) { controller.setScreen(index); },
                items: [
                  BottomNavigationBarItem(label:Word.CLOCK, icon: Icon(Icons.punch_clock_outlined)),
                  BottomNavigationBarItem(label:Word.ALARM, icon: Icon(Icons.lock_clock)),
                  BottomNavigationBarItem(label:Word.RECORD, icon: Icon(Icons.bar_chart)),
                  BottomNavigationBarItem(label:Word.INFO, icon: Icon(Icons.account_circle_outlined)),
                ],
              )
          );
        }
    );
  }
}