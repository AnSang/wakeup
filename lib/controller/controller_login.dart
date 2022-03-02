import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeup/models/login_info.dart';

class LoginController extends GetxController {
  static const key = 'LoginInfo';

  var autoLogin = false.obs;
  var showScreenIndex = 0.obs;
  var isKakaoInstalled = false;

  late SharedPreferences pref;
  late LoginInfo info;

  @override
  void onInit() async {
    pref = await SharedPreferences.getInstance();
    isKakaoInstalled = await isKakaoTalkInstalled();
    super.onInit();
  }

  void setScreen(int index) {
    showScreenIndex = index.obs;
    update();
  }
}