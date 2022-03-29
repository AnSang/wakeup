import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  CrossFadeState isShow = CrossFadeState.showFirst;
  List<Widget> popup = [ Container() ];

  var isProfileImage = true;
  var userName = '안상은';
  var recordCount = '22';

  /// isShowPopupWindow 반전   on/off
  void setPopupOff() {
    isShow = CrossFadeState.showFirst;
    update();
  }
  void setPopupOn() {
    isShow = CrossFadeState.showSecond;
    update();
  }
}