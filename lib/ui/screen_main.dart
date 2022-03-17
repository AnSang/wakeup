import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wakeup/controller/controller_main.dart';
import 'package:wakeup/utils/strings.dart';

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
            body: Column(
              mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded( child: controller.screens[controller.showScreenIndex] ),  // 교체되는 화면
                  Container( color: Colors.white, height: 0.3 )                       // BottomNavigationbar 경계선
                ],
              ),
            bottomNavigationBar: SalomonBottomBar(
              margin: EdgeInsets.symmetric(horizontal: 30),
              selectedColorOpacity: 0.15,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(.60),
              currentIndex: controller.showScreenIndex,
              onTap: (index) { controller.setScreen(index); },
              items: [
                SalomonBottomBarItem(title:Text(Word.CLOCK), icon: Icon(Icons.alarm), selectedColor: Colors.cyanAccent),
                SalomonBottomBarItem(title:Text(Word.ALARM), icon: Icon(Icons.add_alarm), selectedColor: Colors.cyanAccent),
                SalomonBottomBarItem(title:Text(Word.RECORD), icon: Icon(Icons.bar_chart), selectedColor: Colors.cyanAccent),
                SalomonBottomBarItem(title:Text(Word.INFO), icon: Icon(Icons.account_circle_outlined), selectedColor: Colors.cyanAccent),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop
          );
        }
    );
  }
}