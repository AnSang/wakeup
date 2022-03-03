import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeup/models/alarm_info.dart';

class AlarmController extends GetxController {
  static const key = 'alarm';

  var isAlarmCreate = false;
  late SharedPreferences pref;
  List<AlarmInfo> alarmList = [];
  List<bool> daySelect = List.filled(7, false);

  @override
  void onInit() async {
    pref = await SharedPreferences.getInstance();
    setInstance();
    super.onInit();
  }

  void initDaySelect() {  // daySelect init
    for (int i = 0; i < daySelect.length; i++) {
      daySelect[i] = false;
    }
    update();
  }

  void setIsCreate(bool bool) {
    isAlarmCreate = bool;
    update();
  }

  void setBool(int index) {
    alarmList[index].isRun = !alarmList[index].isRun;
    update();
  }

  void setDaySelect(int index) {
    daySelect[index] = !daySelect[index];
    update();
  }

  void setInstance() {
    alarmList.clear();
    alarmList.add(AlarmInfo('14:42:37', List.filled(7, false), false));
    alarmList.add(AlarmInfo('06:11:11', List.filled(7, false), true));
    alarmList.add(AlarmInfo('09:42:37', List.filled(7, false), false));
    alarmList.add(AlarmInfo('14:42:37', List.filled(7, false), false));
    alarmList.add(AlarmInfo('14:42:37', List.filled(7, false), false));
    alarmList.add(AlarmInfo('06:11:11', List.filled(7, false), true));
    alarmList.add(AlarmInfo('09:42:37', List.filled(7, false), false));
    alarmList.add(AlarmInfo('14:42:37', List.filled(7, false), false));
    update();
  }
}