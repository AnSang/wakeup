import 'package:d_button/d_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_chart/time_chart.dart';
import 'package:wakeup/controller/controller_record.dart';

import '../utils/strings.dart';

class ScreenRecord extends StatelessWidget {
  const ScreenRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordController>(
      init: RecordController(),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric( horizontal: 15, vertical: 30),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric( vertical: 3, horizontal: 5 ),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5,
                          spreadRadius: 2
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () { controller.minMonth(); },
                        icon: Icon(Icons.keyboard_arrow_left),
                        color: Colors.white,
                        splashColor: Colors.grey,
                        disabledColor: Colors.grey,
                        iconSize: 40,
                    ),
                    SizedBox(width: 10),
                    Text( controller.getMonth(controller.showDate),
                      style: TextStyle( fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    IconButton(onPressed: () { controller.plusMonth(); },
                       icon: Icon(Icons.keyboard_arrow_right),
                       color: Colors.white,
                       splashColor: Colors.grey,
                        disabledColor: Colors.grey,
                       iconSize: 40,
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              GetBuilder<RecordController>(
                  builder: (controller) {
                    return TimeChart(
                      data: controller.showItems,
                      chartType: ChartType.time,
                      viewMode: ViewMode.monthly,
                      tooltipStart: Word.SLEEP_START,
                      tooltipEnd: Word.SLEEP_END,
                      height: MediaQuery.of(context).size.height * 3 / 5,
                      barColor: Colors.deepPurple,
                    );
                  }
              ),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DButtonShadow(
                      height: 60,
                      width: 150,
                      mainColor: Colors.black,
                      shadowColor: Colors.grey,
                      splashColor: Colors.grey,
                      radius: 15,
                      onClick: () { controller.startRecord(); },
                      child: Text('수면 시작', style: TextStyle( fontSize: 16, color: Colors.white) )
                  ),
                  DButtonShadow(
                      height: 60,
                      width: 150,
                      mainColor: Colors.black,
                      shadowColor: Colors.grey,
                      splashColor: Colors.grey,
                      radius: 15,
                      onClick: () { controller.endRecord(); },
                      child: Text('수면 종료', style: TextStyle( fontSize: 16, color: Colors.white) )
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}