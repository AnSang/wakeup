import 'package:d_button/d_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/controller_info.dart';
import '../main.dart';
import '../utils/strings.dart';

class ScreenInfo extends StatelessWidget {
  const ScreenInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoController>(
      init: InfoController(),
        builder: (controller) {
        return AnimatedCrossFade(
          duration: Duration(seconds: 1),
          crossFadeState: controller.isShow,
          firstChild: Container(
            padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded( // User Profile
                    flex: 1,
                    child: Stack(
                      alignment: Alignment(0, 0),
                      children: [
                        DButtonShadow(
                            radius: 30,
                            height: 120,
                            width:  120,
                            mainColor: Colors.white,
                            splashColor: Colors.grey,
                            shadowColor: Colors.grey,
                            onClick: () => { Fluttertoast.showToast(msg: '눌러졌음') },
                            child: controller.isProfileImage?
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image( image: AssetImage(Word.PATH_IMAGE3) ),
                            ) :
                            Icon( Icons.person, color: Colors.black, size: 60 )
                        ),
                        Align(
                            alignment: Alignment(0, 0),
                            child: Container(
                              padding: EdgeInsets.only(left: 90, top: 90),
                              child: DButtonCircle(
                                disableColor: Colors.white,
                                shadowColor: Colors.grey,
                                diameter: 40,
                                child: Icon( Icons.camera_alt, color: Colors.black, size: 20 ),
                                onClick: () => { Fluttertoast.showToast(msg: '눌러졌음') },
                              ),
                            )
                        ),
                        Align(
                            alignment: Alignment(0, 1),
                            child: Text(
                              '${controller.userName} 님의 총 수면기록 ${controller.recordCount}회',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            )
                        )
                      ],
                    )
                ),
                SizedBox( height: 30 ),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DButtonShadow(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              mainColor: Colors.black,
                              shadowColor: Colors.grey,
                              splashColor: Colors.grey,
                              radius: 15,
                              onClick: () { controller.setPopupOn(); },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(width: 15),
                                  Text( '정보 변경', style: TextStyle(fontSize: 16, color: Colors.white ) ),
                                  Expanded(child: SizedBox()),
                                  Icon(Icons.chevron_right, color: Colors.white),
                                  SizedBox(width: 15)
                                ],
                              )
                          ),
                          SizedBox( height: 20 ),
                          DButtonShadow(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              mainColor: Colors.black,
                              shadowColor: Colors.grey,
                              splashColor: Colors.grey,
                              radius: 15,
                              onClick: () { controller.setPopupOn(); },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(width: 15),
                                  Text( '소리 크기', style: TextStyle(fontSize: 16, color: Colors.white ) ),
                                  Expanded(child: SizedBox()),
                                  Icon(Icons.chevron_right, color: Colors.white),
                                  SizedBox(width: 15)
                                ],
                              )
                          ),
                          SizedBox( height: 20 ),
                          DButtonShadow(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              mainColor: Colors.black,
                              shadowColor: Colors.grey,
                              splashColor: Colors.grey,
                              radius: 15,
                              onClick: () { controller.setPopupOn(); },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(width: 15),
                                  Text( '알람 소리', style: TextStyle(fontSize: 16, color: Colors.white ) ),
                                  Expanded(child: SizedBox()),
                                  Icon(Icons.chevron_right, color: Colors.white),
                                  SizedBox(width: 15)
                                ],
                              )
                          ),
                          SizedBox( height: 20 ),
                          DButtonShadow(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              mainColor: Colors.black,
                              shadowColor: Colors.grey,
                              splashColor: Colors.grey,
                              radius: 15,
                              onClick: () {
                                FirebaseAuth.instance.signOut();
                                Get.off(Authentication());
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(width: 15),
                                  Text( '로그아웃', style: TextStyle(fontSize: 16, color: Colors.white ) ),
                                  Expanded(child: SizedBox()),
                                  Icon(Icons.chevron_right, color: Colors.white),
                                  SizedBox(width: 15)
                                ],
                              )
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
          secondChild: Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: MediaQuery.of(context).size.height - 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 3),
                  ],
                ),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  controller.popup[0],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DButtonElevation(child: Text('cancel'), splashColor: Colors.white, onClick: (){}),
                      SizedBox( width: 30 ),
                      DButtonFlat(child: Text('save'), splashColor: Colors.white, onClick: (){}),
                    ],
                  ),
                  SizedBox( height: 20 )
                ],
              ),
            ),
          ),


        );  
      }
    );
  }
}