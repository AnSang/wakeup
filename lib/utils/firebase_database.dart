import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wakeup/models/alarm_info.dart';

class FirebaseDataBase {
  static const key = 'alarm';

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final User? userInfo = FirebaseAuth.instance.currentUser;

  var alarmList = [];

  /// FireStore Alarm List 가져오기
  void getAlarmList() {
    if (userInfo != null) {
      alarmList.clear();

      _database.collection('${userInfo?.email}').get().then((QuerySnapshot querySnapshot) {
        List<QueryDocumentSnapshot> list = querySnapshot.docs;
        for (QueryDocumentSnapshot row in list) {
          Map<String, dynamic> mapData = row.data() as Map<String, dynamic>;
          AlarmInfo info = AlarmInfo.fromJson(mapData);
          info.document = row.id; // document ID 추
          alarmList.add(info);
        }
      });
    } else {
      Fluttertoast.showToast(msg: '사용자 정보를 가져오지 못했습니다.');
    }
  }


  /// FireStore Alarm 등록하기
  Future<void> addAlarm() async {
    CollectionReference reference = _database.collection('${userInfo?.email}');
    return reference
        .add({
      'index': 0,
      'time': '12:45',
      'isRun': true,
      'day' : [true, false, true, true, false, false, true]
    })
        .then((value) => print("Alarm Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}