import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:wakeup/ui/screen_main.dart';
import 'package:wakeup/utils/strings.dart';

import '../controller/controller_login.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

              Align(
                alignment: Alignment(0 , 1),
                child: MaterialButton(
                  onPressed: () { controller.loginGoogle(); },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 10 * 6,
                    height: 40,
                    margin: EdgeInsets.only(bottom: 200),
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
                    child: SignInButton(
                       Buttons.Google,
                       onPressed: (){ controller.loginGoogle(); },
                    )
                  ),
                ),
              ),

              //////////// Login Button  ////////
              Align(
                alignment: Alignment(0 , 1),
                child: MaterialButton(
                  onPressed: () { controller.loginGoogle(); },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 10 * 6,
                      height: 40,
                      margin: EdgeInsets.only(bottom: 150),
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
                      child: SignInButton(
                        Buttons.FacebookNew,
                        onPressed: (){ controller.loginFacebook(); },
                      )
                  ),
                ),
              ),

              Align(
                alignment: Alignment(0 , 1),
                child: MaterialButton(
                  onPressed: () { controller.loginGoogle(); },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 10 * 6,
                      height: 40,
                      margin: EdgeInsets.only(bottom: 100),
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
                      child: SignInButton(
                        Buttons.GitHub,
                        onPressed: (){ controller.loginGithub(context); },
                      )
                  ),
                ),
              ),

              Align(
                alignment: Alignment(0 , 1),
                  child: Container(
                     width: MediaQuery.of(context).size.width / 10 * 6,
                     height: 40,
                     margin: EdgeInsets.only(bottom: 50),
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
                     child: SignInButton(
                       Buttons.Reddit,
                       onPressed: (){
                         Get.off(() => ScreenMain(), transition: Transition.native);
                         // controller.loginKakao();
                         },
                     )
                  ),
                )
            ],
          );
        }
    );
  }
}