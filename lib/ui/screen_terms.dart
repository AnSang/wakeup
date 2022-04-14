import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeup/utils/strings.dart';

class InfoTerms extends StatelessWidget {
  const InfoTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('개인정보처리방침' , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
          onTap: () { Get.back(); },
        ),
        actions: [
          Icon(Icons.arrow_back_ios, color: Colors.white)
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
          child: Text(Word.TERMS)
      )
    );
  }

}