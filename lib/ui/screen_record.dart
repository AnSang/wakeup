import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_chart/time_chart.dart';
import 'package:wakeup/controller/controller_record.dart';

class ScreenRecord extends StatelessWidget {
  const ScreenRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordController>(
      init: RecordController(),
      builder: (controller) {
        return Container(
          color: Colors.black,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox( height: 20 ),
              Container(
                padding: EdgeInsets.symmetric( vertical: 3, horizontal: 5 ),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
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
                        iconSize: 40,
                    ),
                    SizedBox(width: 10),
                    Text( controller.getMonth(controller.showDate),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    IconButton(onPressed: () { controller.plusMonth(); },
                       icon: Icon(Icons.keyboard_arrow_right),
                       color: Colors.white,
                       iconSize: 40,
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return TimeChart(
                      data: controller.showItems,
                      chartType: ChartType.time,
                      viewMode: ViewMode.monthly,
                      height: MediaQuery.of(context).size.height * 2 / 3,
                      barColor: Colors.deepPurple,
                    );
                  }
              )
            ],
          ),
        );
      }
    );
  }
}