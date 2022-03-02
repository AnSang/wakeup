import 'package:flutter/material.dart';

class ScreenClock extends StatelessWidget {
  const ScreenClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('This is Clock Screen',
      style: TextStyle(
          color: Colors.white,
        fontSize: 35
      )
    );
  }
}