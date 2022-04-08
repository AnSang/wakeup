import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../controller/controller_alarm.dart';
import '../utils/custom_colors.dart';
import '../utils/strings.dart';

final AlarmController controller = Get.put(AlarmController());

class ScreenAlarm extends StatelessWidget {
  const ScreenAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlarmController>(
      init: AlarmController(),
      builder: (controller) {
          return Stack(
            alignment: Alignment(0, 0),
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: controller.alarmList.map<Widget>((alarm) {
                    var alarmTime = alarm.time;
                    var gradientColor = GradientTemplate.gradientTemplate[2].colors;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric( horizontal: 16, vertical: 8 ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColor,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: gradientColor.last.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(4, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon( Icons.label, color: Colors.white, size: 24 ),
                                  SizedBox(width: 8),
                                  Text(
                                    'title',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  ),
                                ],
                              ),
                              Switch(
                                value: alarm.isRun,
                                onChanged: (val) { controller.setBool(alarm.index); },
                                activeColor: Colors.white,
                              ),
                            ],
                          ),
                          Text(
                              controller.getDays(alarm.index),
                              style: TextStyle(color: Colors.white, fontFamily: 'avenir' )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                alarmTime,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'avenir',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.white,
                                  onPressed: () {
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
                                                    controller.delAlarm(alarm.index);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('확인')
                                              )
                                            ],
                                          );
                                        }
                                    );
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).followedBy([
                    DottedBorder(
                      strokeWidth: 2,
                      color: CustomColors.clockOutline,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(24),
                      dashPattern: [5, 4],
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: CustomColors.clockBG,
                          borderRadius:
                          BorderRadius.all(Radius.circular(24)),
                        ),
                        child:
                        MaterialButton(
                          padding: const EdgeInsets.symmetric( horizontal: 32, vertical: 16 ),
                          onPressed: () {
                            controller.alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              builder: (context) {
                                return GetBuilder<AlarmController>(
                                  builder: (controller) {
                                    return  Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.symmetric( vertical: 20 ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MaterialButton(
                                            onPressed: () async {
                                              var selectedTime = await showTimePicker( context: context, initialTime: TimeOfDay.now() );
                                              if (selectedTime != null) {
                                                controller.setTimePicker(selectedTime);
                                              }
                                            },
                                            child: Text(
                                              controller.alarmTimeString,
                                              style: TextStyle(fontSize: 32),
                                            ),
                                          ),
                                          WeekdaySelector(    /// 요일 정하기
                                            shortWeekdays: Word.WEEKEND,
                                            selectedFillColor: Colors.indigo.shade300,
                                            onChanged: (int day) { controller.setDaySelect(day % 7); },
                                            values: controller.daySelect,
                                          ),
                                          ListTile(
                                            title: Text('Title'),
                                            trailing: Icon(
                                                Icons.arrow_forward_ios),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FloatingActionButton.extended(
                                                onPressed: (){
                                                  controller.initDaySelect();
                                                  controller.initTimeOfDay();
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.cancel_outlined),
                                                label: Text('Cancel'),
                                              ),
                                              FloatingActionButton.extended(
                                                onPressed: (){
                                                  if (controller.checkDaySelect()) {
                                                    controller.addAlarm();
                                                    controller.initDaySelect();
                                                    controller.initTimeOfDay();
                                                    Navigator.pop(context);
                                                  } else {
                                                    Fluttertoast.showToast(msg: '요일을 선택해주세요.');
                                                  }
                                                },
                                                icon: Icon(Icons.alarm),
                                                label: Text('Save'),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                );
                              },
                            );
                            // scheduleAlarm();
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'image/add_alarm.png',
                                scale: 1.5,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Add Alarm',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'avenir'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]).toList(),
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