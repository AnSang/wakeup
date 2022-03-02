import 'package:flutter/material.dart';

class ScreenInfo extends StatelessWidget {
  const ScreenInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('This is Info Screen',
        style: TextStyle(
            color: Colors.white,
            fontSize: 35
        )
    );
  }
}