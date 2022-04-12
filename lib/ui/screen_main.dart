import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wakeup/controller/controller_main.dart';
import 'package:wakeup/utils/strings.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Stack(
              alignment: Alignment(0 , 0),
                children: [
                  Scaffold(
                      backgroundColor: Colors.black,
                      body: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded( child: controller.screens[controller.showScreenIndex] ),  // 교체되는 화면
                          Container( color: Colors.white, height: 0.3 ),                      // BottomNavigationbar 경계선
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
                  ),

                  if (controller.isShowProgress)
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(128, 128, 128, 0.7),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5),
                        ],
                      ),
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 60,
                      ),
                    )
                ]
            ),
          );
        }
    );
  }
}