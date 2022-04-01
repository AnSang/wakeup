import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../ui/screen_main.dart';
import '../utils/firebase_auth.dart';

class LoginController extends GetxController {
  static const key = 'LoginInfo';

  var autoLogin = false;
  var showScreenIndex = 0;

  FirebaseAuthentication auth = FirebaseAuthentication();

  void setScreen(int index) {
    showScreenIndex = index;
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

  /*void loginKakao() {
    auth.signInWithKaKao().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: 'KaKao Login Fail');
      } else {
        Fluttertoast.showToast(msg: 'KaKao Login Success');
        Get.off(() => ScreenMain());
      }
    });
  }*/
}