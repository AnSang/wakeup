import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wakeup/models/login_info.dart';

import '../ui/screen_main.dart';
import '../utils/firebaseauth.dart';

class LoginController extends GetxController {
  static const key = 'LoginInfo';

  var autoLogin = false.obs;
  var showScreenIndex = 0.obs;
  var isKakaoInstalled = false;

  FirebaseAuthentication auth = FirebaseAuthentication();

  late LoginInfo info;

  @override
  void onInit() async {
    // isKakaoInstalled = await isKakaoTalkInstalled();
    super.onInit();
  }

  void setScreen(int index) {
    showScreenIndex = index.obs;
    update();
  }

  void loginGoogle() {
    auth.loginWithGoogle().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: 'Google Login Fail');
      } else {
        Fluttertoast.showToast(msg: 'Google Login Success');
        Get.off(() => ScreenMain());
      }
    });
  }
}