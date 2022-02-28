import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeup/models/login_info.dart';

class ScreenController extends GetxController {
  static const key = 'LoginInfo';

  var autoLogin = false;
  var showScreenIndex = 0;

  late SharedPreferences pref;
  late LoginInfo info;

  @override
  void onInit() async {
    pref = await SharedPreferences.getInstance();
    super.onInit();
  }

  void setScreen(int index) {
    showScreenIndex = index;
    update();
  }
}