import 'package:get/get.dart';
import 'package:wakeup/models/login_info.dart';
import 'package:wakeup/ui/screen_alarm.dart';
import 'package:wakeup/ui/screen_clock.dart';
import 'package:wakeup/ui/screen_info.dart';
import 'package:wakeup/ui/screen_record.dart';

class MainController extends GetxController {
  static const key = 'Main';
  List screens = [ ScreenClock(), ScreenAlarm(), ScreenRecord(), ScreenInfo() ]; // Screen List

  var showScreenIndex = 0;            // Screen List, Menu List   Index

  late LoginInfo info;

  @override
  void onInit() async {
    super.onInit();
  }

  void setScreen(int index) {
    showScreenIndex = index;
    update();
  }
}