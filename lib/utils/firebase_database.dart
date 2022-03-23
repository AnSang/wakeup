import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wakeup/models/alarm_info.dart';

class FirebaseDataBase {
  static const key = 'alarm';

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final User? userInfo = FirebaseAuth.instance.currentUser;

  List<AlarmInfo> alarmList = [];

  /// FireStore Alarm List 가져오기
  Future<void> getAlarmList() async {
    CollectionReference reference = _database.collection('${userInfo?.email}');
    return reference.get().then((snapshot) {
      alarmList.clear();
      List<QueryDocumentSnapshot> list = snapshot.docs;
      for (QueryDocumentSnapshot row in list) {
        Map<String, dynamic> mapData = row.data() as Map<String, dynamic>;
        AlarmInfo info = AlarmInfo.fromJson(mapData);
        info.document = row.id; // document ID 추가
        alarmList.add(info);
      }
      alarmList.sort((a, b) => a.index.compareTo(b.index));
    });
  }


  /// FireStore Alarm 등록하기
  Future<void> addAlarm(AlarmInfo info) async {
    CollectionReference reference = _database.collection('${userInfo?.email}');
    return reference
        .add({
      'index': info.index,
      'time': info.time,
      'isRun': info.isRun,
      'day' : info.day
    })
        .then((value) => print("Alarm Add"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  /// FireStore Alarm 수정하기
  Future<void> updateAlarm(AlarmInfo info) {
    CollectionReference reference = _database.collection('${userInfo?.email}');
    return reference
        .doc('${info.document}')
        .update({
          'index': info.index,
          'time': info.time,
          'isRun': info.isRun,
          'day': info.day
        })
        .then((value) => print("Alarm Update"))
        .catchError((error) => print("Failed to update Alarm: $error"));
  }

  /// FireStore Alarm 수정하기 , no Refresh
  Future<void> onlyUpdateAlarm(AlarmInfo info) {
    CollectionReference reference = _database.collection('${userInfo?.email}');
    return reference
        .doc('${info.document}')
        .update({
      'index': info.index,
      'time': info.time,
      'isRun': info.isRun,
      'day': info.day
    })
        .catchError((error) => print("Failed to update Alarm: $error"));
  }

  /// FireStore Alarm 삭제하기
  Future<void> deleteAlarm(int index) {
    CollectionReference reference = _database.collection('${userInfo?.email}');
    return reference
        .doc(alarmList[index].document)
        .delete()
        .then((value) => print("Alarm Delete"))
        .catchError((error) => print("Failed to delete Alarm: $error"));
  }

  /// FireStore Alarm Index Sort
  Future<void> sortIndexAlarm() async {
    for (int i = 0; i < alarmList.length; i++) {
      alarmList[i].index = i;
      if (i < alarmList.length-1) {
        onlyUpdateAlarm(alarmList[i]);
      } else {
        return updateAlarm(alarmList[i]);
      }
    }
  }

}