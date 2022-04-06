import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_info.dart';
import '../utils/firebase_database.dart';
import 'controller_main.dart';

class InfoController extends GetxController {
  CrossFadeState isShow = CrossFadeState.showFirst;
  int selBtnNum = -1;
  // List<Widget> popup = [ InfoModify() ];
  FirebaseDataBase dataBase = Get.find<MainController>().dataBase;
  TextEditingController editController = TextEditingController();

  late UserInfoLocal info;

  @override
  void onInit() {
    initInfo();
    super.onInit();
  }

  /// init NickName, info
  void initInfo() {
    info = UserInfoLocal(name: dataBase.userInfoLocal.name, volume: dataBase.userInfoLocal.volume * 100);
    editController.clear();
    update();
  }

  /// isShowPopupWindow 반전   on/off
  void setPopupOff() {
    isShow = CrossFadeState.showFirst;
    update();
  }
  void setPopupOn() {
    isShow = CrossFadeState.showSecond;
    update();
  }

  /// Volume 값 설정
  void setVolume(double value) {
    info.volume = value;
    update();
  }

  /// 사용자 정보 변경 어떤 버튼 눌렀는지 check
  void setSelBtnNum(int num) {
    selBtnNum = num;
    update();
  }

  void setUserName() {
    info.name = editController.text;
  }

  /// Info 설정 값 FireStore에 저장
  void updateInfo() async {
    await dataBase.updateInfo(UserInfoLocal(name: info.name, volume: info.volume / 100));
    dataBase.userInfoLocal = info;
    update();
  }

  /// 프로필 사진 업로드
  void upLoadPhoto(XFile file) async {
   await dataBase.uploadFile(file);
   update();
  }

  /// 프로필 사진 다운로드
  void downloadPhoto() async {
    await dataBase.downloadFile();
    update();
  }
}