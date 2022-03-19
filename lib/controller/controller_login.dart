import 'package:flutter/cupertino.dart';
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

  void loginFacebook() {
    auth.signInWithFacebook().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: 'FaceBook Login Fail');
      } else {
        Fluttertoast.showToast(msg: 'FaceBook Login Success');
        Get.off(() => ScreenMain());
      }
    });
  }

  void loginGithub(BuildContext context) {
    auth.signInWithGitHub(context).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: 'Github Login Fail');
      } else {
        Fluttertoast.showToast(msg: 'Github Login Success');
        Get.off(() => ScreenMain());
      }
    });
  }

  void loginKakao() {
    auth.signInWithKaKao().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: 'KaKao Login Fail');
      } else {
        Fluttertoast.showToast(msg: 'KaKao Login Success');
        Get.off(() => ScreenMain());
      }
    });
  }
}