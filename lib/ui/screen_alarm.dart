import 'package:d_button/d_button.dart';
import 'package:flutter/material.dart';

class ScreenAlarm extends StatelessWidget {
  const ScreenAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(child: SizedBox()),  //Todo Alarm ListView 추가
          DButtonCircle(          // 알람 추가 버튼
            mainColor: Colors.white,
            diameter: 40,
            child: Icon( Icons.add, color: Colors.black ),
            onClick: () {},
          ),
          SizedBox(height: 10)
        ],
      );
  }
}