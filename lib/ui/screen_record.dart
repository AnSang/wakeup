import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wakeup/controller/controller_record.dart';
import 'package:wakeup/models/alarm_record.dart';

import '../utils/custom_colors.dart';

class ScreenRecord extends StatelessWidget {
  const ScreenRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordController>(
      init: RecordController(),
      builder: (controller) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric( vertical: 3, horizontal: 15 ),
              decoration: BoxDecoration(
                  color: Colors.white,
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
                      icon: Icon(Icons.keyboard_arrow_left)),
                  SizedBox(width: 10),
                  Text( controller.getMonth() ),
                  SizedBox(width: 10),
                  IconButton(onPressed: () { controller.plusMonth(); },
                      icon: Icon(Icons.keyboard_arrow_right))
                ],
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    legend: Legend(isVisible: false),                   // 우측에 선에 대한 설명 표시
                    palette: GradientColors.sky,
                    tooltipBehavior: TooltipBehavior(
                        enable: true,
                        format: 'point.x 일 : point.y 회'
                    ),
                    series: <ChartSeries<AlarmRecord, String>>[
                      LineSeries<AlarmRecord, String>(
                          dataSource: controller.showItems,
                          xValueMapper: (AlarmRecord row, _) => row.date.substring(8,10),
                          yValueMapper: (AlarmRecord row, _) => row.count,
                          name: 'Weight',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]
                )
              ],
            )
          ],
        );
      }
    );
  }
}