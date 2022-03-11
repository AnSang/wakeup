import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeup/utils/strings.dart';
import 'package:wakeup/ui/screen_main.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/all.dart';

import '../controller/controller_login.dart';

final LoginController controller = Get.put(LoginController());
var _context;

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Stack(
            children: [
              Container(  // 밑 바탕 배경색
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
              ),
              Align(  // 배경 이미지 설정
                alignment: Alignment(0 , -1),
                child: Image(image: AssetImage(Word.PATH_IMAGE2)),  // 배경 이미지 경로
              ),
              /*Align(
                alignment: Alignment(0 , 1),
                child: Container(
                  width: MediaQuery.of(context).size.width / 10 * 6,
                  height: MediaQuery.of(context).size.height / 10 * 3,
                  margin: EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5
                        )
                      ]
                  ),
                ),
              ),*/
              LoginButton(onPressed: (){}, margin: 40, buttonName: '카카오톡 로그인하기'),
              LoginButton(onPressed: (){}, margin: 90, buttonName: '카카오톡 로그인하기'),
              LoginButton(onPressed: (){}, margin: 140, buttonName: '카카오톡 로그인하기'),
              LoginButton(onPressed: (){}, margin: 190, buttonName: '카카오톡 로그인하기')
            ],
          );
        }
    );
  }

  //////////////// Sign In Method //////////////////
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String> signInWithKakao() async {
    KakaoContext.clientId = 'aa2066b021be69a35115d04dfbffb4bb';
    return await AuthCodeClient.instance.request();
  }


  _issueAccessToken(String authCode) async {
    try {
      // const keyHash = 'hmNYgOU/ytmn0MQoIJehlSPa7qg=';
      var token = await AuthApi.instance.issueAccessToken(authCode);
      var val = DefaultTokenManager().setToken(token);
      var aaa = _getUser();
      print(aaa);
      Get.off(() => ScreenMain());
    } catch (e) {
      print('error on issuing access token: $e');
    }
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _getUser() async {
    try {
      var user = await UserApi.instance.me();
      print(user.toString());
      return true;
    } on KakaoAuthException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return true;
    }
  }
}

class LoginButton extends StatelessWidget {
  LoginButton({Key? key,
    required this.onPressed,
    required this.margin,
    required this.buttonName
  }) : super(key: key);

  final VoidCallback onPressed;
  final double margin;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0 , 1),
      child: MaterialButton(
        onPressed: () async {
          // Future<UserCredential> val = signInWithGoogle();

          // KakaoContext.clientId = 'aa2066b021be69a35115d04dfbffb4bb';
          // controller.isKakaoInstalled ? _loginWithTalk() : _loginWithKakao();

          Get.off(() => ScreenMain());
          onPressed;
        },
        child: Container(
          width: MediaQuery.of(_context).size.width / 10 * 6,
          height: 40,
          margin: EdgeInsets.only(bottom: margin),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5
                )
              ]
          ),
          child: Align(
            alignment: Alignment(0 , 0),
            child: Text(
              buttonName,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

}