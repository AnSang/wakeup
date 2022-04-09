import 'package:d_button/d_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wakeup/ui/btn_info.dart';
import 'package:wakeup/utils/strings.dart';

import '../controller/controller_info.dart';

class ScreenInfo extends StatelessWidget {
  const ScreenInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoController>(
        init: InfoController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.only(top: 80, bottom: 10, left: 10, right: 10),
            child: SingleChildScrollView(
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
                              )
                          )
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
                        InfoButton(btnNum: 0, btnName: '정보 변경', controller: controller ),
                        SizedBox(height: 20),
                        InfoButton(btnNum: 1, btnName: '알람 소리', controller: controller ),
                        SizedBox(height: 20),
                        InfoButton(btnNum: 2, btnName: '로그 아웃', controller: controller ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
                  child: const Text(Word.CANCEL),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text(Word.CONFIRM),
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