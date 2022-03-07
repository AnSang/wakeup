import 'package:d_button/d_button.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../controller/controller_alarm.dart';

final AlarmController controller = Get.put(AlarmController());

class ScreenAlarm extends StatelessWidget {
  const ScreenAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<AlarmController>(
      init: AlarmController(),
      builder: (controller) {
        return
          Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
                      child: ListTileTheme(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        textColor: Colors.black,
                        tileColor: Colors.white,
                        style: ListTileStyle.list,
                        selectedTileColor: Colors.redAccent,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: controller.alarmList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return setListItem(context, index);
                            }
                        ),
                      ),
                    )
                ),
                DButtonCircle(          // 알람 추가 버튼
                    mainColor: Colors.white,
                    diameter: 40,
                    child: Icon( Icons.add, color: Colors.black ),
                    onClick: () {
                      controller.setIsCreate(true);
                    }
                ),
                SizedBox(height: 10)
              ],
            ),

            if (controller.isAlarmCreate)
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 230, 230, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    createInlinePicker(   /// 시간 정하기
                      isOnChangeValueMode: true,
                      value: controller.timeOfDay,
                      onChange: (time) { controller.setTimeOfDay(time); },
                    ),
                    WeekdaySelector(    /// 요일 정하기
                        selectedFillColor: Colors.indigo.shade300,
                        onChanged: (int day) { controller.setDaySelect(day % 7); },
                        values: controller.daySelect
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DButtonShadow(
                          mainColor: Colors.white,
                          splashColor: Colors.grey,
                          onClick: () => {
                            controller.initTimeOfDay(),
                            controller.initDaySelect(),
                            controller.setIsCreate(false)
                          },
                          radius: 30,
                          height: 35,
                          child: Text(
                            "취소",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        DButtonShadow(
                          mainColor: Colors.white,
                          splashColor: Colors.grey,
                          onClick: () => {
                            if (controller.isAlarmModify == -1) {
                              controller.addAlarm()
                            } else {
                              controller.mSave(controller.isAlarmModify)
                            },
                            controller.initTimeOfDay(),
                            controller.initDaySelect(),
                            controller.setIsCreate(false)
                          },
                          radius: 30,
                          height: 35,
                          child: Text(
                            "등록",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
          ],
        );
      }
    );
  }

  Widget setListItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 5),
        ],
      ),
      child: Slidable(
        child: Row(
          children: [
            Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                        controller.alarmList[index].time,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox( height: 10 ),
                    WeekdaySelector(
                        selectedFillColor: Colors.indigo.shade300,
                        onChanged: (int day) { }, // 표시만 하기 위해 이벤트는 넣지 않음
                        values: controller.alarmList[index].day.cast<bool>(),
                        textStyle: TextStyle( fontSize: 12, color: Colors.black ),
                        selectedTextStyle: TextStyle( fontSize: 12 ),
                    ),
                    SizedBox(height: 10)
                  ],
                )
            ),
            Switch(
                value: controller.alarmList[index].isRun,
                onChanged: (val){ controller.setBool(index); }
            ),
          ],
        ),

        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
                onPressed: (context) { controller.mModify(index); },
                backgroundColor: Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.app_registration,
                label: 'Modify'
            ),
            SlidableAction(
                onPressed: (context) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          content: Text('삭제 하시겠습니까?'),
                          actions: [
                            TextButton(
                                onPressed: () { Navigator.pop(context); },
                                child: Text('취소')
                            ),
                            TextButton(
                                onPressed: () {
                                  controller.delAlarm(index);
                                  Navigator.pop(context);
                                },
                                child: Text('확인')
                            )
                          ],
                        );
                      }
                  );
                    // onWillPop: (val) => { controller.delAlarm(index); }
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete_forever,
                label: 'Delete'
            ),
          ],
        )
      ),
    );
  }

}