import 'package:d_button/d_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wakeup/utils/strings.dart';

import '../controller/controller_info.dart';
import '../main.dart';

class ScreenInfo extends StatelessWidget {
  const ScreenInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoController>(
        init: InfoController(),
        builder: (controller) {
          return AnimatedCrossFade(
            duration: Duration(milliseconds: 500),
            crossFadeState: controller.isShow,
            firstChild: Container(
              padding: EdgeInsets.only(top: 80, bottom: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox( // User Profile
                    child: Stack(
                    alignment: Alignment(0, 0),
                    children: [
                      DButtonShadow(
                          radius: 30,
                          height: 120,
                          width: 120,
                          mainColor: Colors.white,
                          splashColor: Colors.grey,
                          shadowColor: Colors.grey,
                          onClick: () => { onImageButtonPressed(context, controller) },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: controller.dataBase.image ?? Image(image: AssetImage(Word.PATH_IMAGE3)),
                          )
                      ),
                      Align(
                          alignment: Alignment(0, 0),
                          child: Container(
                            padding: EdgeInsets.only(left: 90, top: 90),
                            child: DButtonCircle(
                              disableColor: Colors.white,
                              shadowColor: Colors.grey,
                              diameter: 40,
                              child: Icon(Icons.camera_alt,
                                  color: Colors.black, size: 20),
                              onClick: () =>
                                  { onImageButtonPressed(context, controller) },
                            ),
                          ))
                    ],
                  )),
                  SizedBox(height: 20),
                  Text(
                    '${controller.dataBase.userInfoLocal.name} 님의 총 수면기록 ${controller.dataBase.userInfoLocal.count}회',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Container(
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
                            onClick: () {
                              controller.setSelBtnNum(0);
                              controller.setPopupOn();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(width: 15),
                                Text('정보 변경',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.chevron_right, color: Colors.white),
                                SizedBox(width: 15)
                              ],
                            )),
                        SizedBox(height: 20),
                        DButtonShadow(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            mainColor: Colors.black,
                            shadowColor: Colors.grey,
                            splashColor: Colors.grey,
                            radius: 15,
                            onClick: () {
                              controller.setSelBtnNum(1);
                              controller.setPopupOn();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(width: 15),
                                Text('소리 크기',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.chevron_right, color: Colors.white),
                                SizedBox(width: 15)
                              ],
                            )),
                        SizedBox(height: 20),
                        DButtonShadow(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            mainColor: Colors.black,
                            shadowColor: Colors.grey,
                            splashColor: Colors.grey,
                            radius: 15,
                            onClick: () {
                              Fluttertoast.showToast(msg: '개발 예정입니다.');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(width: 15),
                                Text('알람 소리',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.chevron_right, color: Colors.white),
                                SizedBox(width: 15)
                              ],
                            )),
                        SizedBox(height: 20),
                        DButtonShadow(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            mainColor: Colors.black,
                            shadowColor: Colors.grey,
                            splashColor: Colors.grey,
                            radius: 15,
                            onClick: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      content: Text('로그아웃 하시겠습니까?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('취소')),
                                        TextButton(
                                            onPressed: () {
                                              FirebaseAuth.instance.signOut();
                                              Get.off(Authentication());
                                            },
                                            child: Text('확인'))
                                      ],
                                    );
                                  });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(width: 15),
                                Text('로그아웃',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.chevron_right, color: Colors.white),
                                SizedBox(width: 15)
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            secondChild: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.selBtnNum == 0) infoModify(controller),
                    if (controller.selBtnNum == 1) soundControll(controller),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            controller.initInfo();
                            controller.setSelBtnNum(-1);
                            controller.setPopupOff();
                          },
                          label: Text('Cancel'),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            if (controller.selBtnNum == 0) {
                              controller.setUserName();
                            }
                            controller.updateInfo();
                            controller.setSelBtnNum(-1);
                            controller.setPopupOff();
                          },
                          label: Text('Save'),
                        )
                      ],
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget infoModify(InfoController controller) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: controller.editController,
        style: TextStyle(color: Colors.white, fontSize: 14),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: 'Hint',
          hintText: '닉네임을 입력하세요.',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          suffixIcon: GestureDetector(
            child: const Icon(
              Icons.cancel,
              color: Colors.blueAccent,
              size: 20,
            ),
            onTap: () => controller.editController.clear(),
          ),
        ),
      ),
    );
  }

  Widget soundControll(InfoController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Column(children: [
        Text(
          'Volume: ${controller.info.volume.round()}%',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Slider(
          value: controller.info.volume,
          min: 0,
          max: 100,
          divisions: 100,
          label: controller.info.volume.round().toString(),
          onChanged: (double value) {
            controller.setVolume(value);
          },
        )
      ]),
    );
  }
}
Future<void> onImageButtonPressed(BuildContext context, InfoController controller) async {
  final ImagePicker _picker = ImagePicker();
  try {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('사진을 업로드 하시겠습니까 ?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text('확인'),
                    onPressed: () {
                      controller.upLoadPhoto(image);
                      Navigator.of(context).pop();
                    }),
              ],
            );
          }
      );
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Pick image error: $e');
  }
}
