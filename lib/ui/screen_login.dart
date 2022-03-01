import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:wakeup/stringword.dart';
import 'package:wakeup/ui/screen_main.dart';

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
              setButton(40),
              setButton(90),
              setButton(140),
              setButton(190),
            ],
          );
        }
    );
  }

  Widget setButton(double margin) {
    return Align(
      alignment: Alignment(0 , 1),
      child: MaterialButton(
        onPressed: () async {
          // Future<UserCredential> val = signInWithGoogle();
          Future<void> val = signInWithKakao();
          /*if (val == null) {
            print('null');
          } else {
            Get.off(() => ScreenMain());
          }*/
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
              '카카오톡 로그인 하기',
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

  Future<void> signInWithKakao() async {
    KakaoContext.clientId = 'aa2066b021be69a35115d04dfbffb4bb';
    String authCode = await AuthCodeClient.instance.request();
    print(authCode);
  }
}