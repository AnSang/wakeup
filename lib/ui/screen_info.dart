import 'package:d_button/d_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/controller_info.dart';
import '../utils/strings.dart';

class ScreenInfo extends StatelessWidget {
  const ScreenInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoController>(
      init: InfoController(),
        builder: (controller) {
        return Container(
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
                              diameter: 50,
                              child: Icon( Icons.camera_alt, color: Colors.black, size: 20 ),
                              onClick: () => { Fluttertoast.showToast(msg: '눌러졌음') },
                          ),
                        )
                      )
                    ],
                  )
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${controller.userName} 님의 총 수면기록 ${controller.recordCount}회',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox( height: 30 ),
                      ListView(
                        children: [
                          ListTile(),
                          ListTile(),
                          ListTile(),
                        ],
                      )
                    ],
                  )
              )
            ],
          ),
        );
      }
    );
  }
}