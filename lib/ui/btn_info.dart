import 'package:d_button/d_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeup/controller/controller_info.dart';
import 'package:wakeup/utils/strings.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class InfoButton extends StatelessWidget {
  // final BuildContext context;
  final InfoController controller;
  final int btnNum;
  final String btnName;

  InfoButton({Key? key,
    // required this.context,
    required this.controller,
    required this.btnNum,
    required this.btnName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DButtonShadow(
        height: 60,
        width: MediaQuery.of(context).size.width,
        mainColor: Colors.black,
        shadowColor: Colors.grey,
        splashColor: Colors.grey,
        radius: 15,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 15),
            Text( btnName , style: TextStyle( fontSize: 16, color: Colors.white ) ),
            Expanded(child: SizedBox()),
            Icon(Icons.chevron_right, color: Colors.white),
            SizedBox(width: 15)
          ],
        ),

        onClick: () {
          if (btnNum == 0 || btnNum == 1) {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.vertical( top: Radius.circular(24) ) ),
                builder: (context) {
                  return GetBuilder<InfoController>(
                    builder: (controller) {
                      return KeyboardVisibilityBuilder(
                        builder: (BuildContext context , bool isKeyboardVisible) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (btnNum == 0)
                                  infoModify()
                                else if (btnNum == 1)
                                  soundControll(context)

                                , SizedBox( height: 30 ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      DButtonShadow(
                                          height: 60,
                                          width: 150,
                                          mainColor: Colors.black,
                                          shadowColor: Colors.grey,
                                          disableColor: Colors.black87,
                                          radius: 15,
                                          child: Text(Word.CANCEL, style: TextStyle(fontSize: 16, color: Colors.white) ),
                                          onClick: (){
                                            Navigator.pop(context);
                                          },
                                      ),

                                      DButtonShadow(
                                          height: 60,
                                          width: 150,
                                          mainColor: Colors.black,
                                          shadowColor: Colors.grey,
                                          disableColor: Colors.black87,
                                          radius: 15,
                                          child: Text(Word.CONFIRM, style: TextStyle(fontSize: 16, color: Colors.white) ),
                                          onClick: (){
                                            if (btnNum == 0) {
                                              controller.setUserName();
                                            } else if (btnNum == 1) {
                                              controller.setSoundName(Word.SOUND_VALUE[controller.selectSound]);
                                            }
                                            controller.updateInfo();
                                            Navigator.pop(context);
                                          }
                                      )
                                    ]
                                ),
                                SizedBox( height: 30 ),

                                if (isKeyboardVisible)
                                  SizedBox( height: MediaQuery.of(context).size.height / 3)
                              ]
                          );
                        }
                      );
                    },
                  );
                }
            );
          } else if ( btnNum == 2 ) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0) ),
                    content: Text(Word.LOGOUT),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(Word.CANCEL)),
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            // controller.off
                            // Get.off(Authentication());
                          },
                          child: Text(Word.CONFIRM))
                    ],
                  );
                }
            );
          }
        }
    );
  }

  Widget infoModify() {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: controller.editController,
        style: TextStyle(color: Colors.black, fontSize: 14),
        cursorColor: Colors.black,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: Word.NICKNAME,
          hintText: Word.INPUT_NICKNAME,
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

  /*Widget volumeControll() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Column(children: [
        Text(
          'Volume: ${controller.info.volume.round()}%',
          style: TextStyle(color: Colors.black, fontSize: 16),
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
  }*/

  Widget soundControll(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric( horizontal: 40, vertical: 40 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: ListWheelScrollView.useDelegate(
        itemExtent: 30,
        physics: FixedExtentScrollPhysics(),
        diameterRatio: 1.3,
        useMagnifier: true,
        magnification: 1.5,
        onSelectedItemChanged: (value) { controller.selectSound = value; },
        childDelegate: ListWheelChildBuilderDelegate(
            childCount: Word.SOUND_NAME.length,
            builder: (BuildContext context, int index) {
              if (index < 0 || index > Word.SOUND_NAME.length) {
                return null;
              }
              return Text(Word.SOUND_NAME[index], style: TextStyle(color: Colors.black, fontSize: 20) );
            }
        ),
      ),
    );
  }
}