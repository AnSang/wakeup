import 'package:flutter/material.dart';

class ScreenRecord extends StatelessWidget {
  const ScreenRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('This is Record Screen',
        style: TextStyle(
            color: Colors.white,
            fontSize: 35
        )
    );
  }
}