import 'package:flutter/material.dart';

class ScreenAlarm extends StatelessWidget {
  const ScreenAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('This is Alarm Screen',
        style: TextStyle(
            color: Colors.white,
            fontSize: 35
        )
    );
  }
}