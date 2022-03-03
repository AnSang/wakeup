import 'package:d_button/d_button.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../controller/controller_alarm.dart';

final AlarmController controller = Get.put(AlarmController());

class ScreenAlarm extends StatelessWidget {
  const ScreenAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlarmController>(
      init: AlarmController(),
      builder: (controller) {
        return Stack(
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
              Expanded(
                child: Container(
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
                      createInlinePicker(
                        isOnChangeValueMode: true,
                        onChange: (TimeOfDay) {  },
                        value: TimeOfDay.now()
                      ),
                      WeekdaySelector(
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
                            onClick: () => { controller.setIsCreate(false) },
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
                            onClick: () => { controller.setIsCreate(false) },
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
                ),
              )
          ],
        );
      }
    );
  }

  Widget setListItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(10),
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
      child: Row(
        children: [
          Expanded(child: Container()),
          Switch(
              value: controller.alarmList[index].isRun,
              onChanged: (val){
                controller.setBool(index);
          }),
        ],
      ),

      //Text('Title : ${controller.alarmList[index].time}')
    );
  }
}