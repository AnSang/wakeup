import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:wakeup/ui/btn_login.dart';
import 'package:wakeup/ui/screen_terms.dart';
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
                child: Column(
                    children: [
                      SizedBox( height: 80 ),
                      Image(image: AssetImage(Word.PATH_IMAGE2)),  // 배경 이미지 경로
                    ]
                  )
              ),


              //////////// Login Button  ////////
              Align(
                alignment: Alignment(0 , 1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LoginButton(buttons: Buttons.Google, onPressed: (){ controller.loginGoogle(); } ),
                    LoginButton(buttons: Buttons.FacebookNew, onPressed: (){ controller.loginFacebook(); } ),
                    LoginButton(buttons: Buttons.GitHub, onPressed: (){ controller.loginGithub(context); } ),
                    LoginButton(buttons: Buttons.Reddit, onPressed: (){  } ),

                    Material(
                      color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                side: BorderSide(color: Colors.white),
                                activeColor: Colors.lightBlueAccent,
                                value: controller.chkTerms,
                                onChanged: (value) => controller.setTerms(value)
                              ),
                              Text(Word.TERMS_AGREE, style: TextStyle( color: Colors.white, fontSize: 14 ) ),
                              SizedBox( width: 10 ),
                              TextButton(
                                child: Text(Word.TERMS_SHOW,
                                  style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold ),
                                ),
                                onPressed: () { Get.to(InfoTerms()); }
                              )
                            ]
                        )
                    ),
                    SizedBox( height: 30 )
                  ],
                ),
              )
            ],
          );
        }
    );
  }
}