import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wakeup/models/alarm_record.dart';

class RecordController extends GetxController {
  var showDate = DateTime.now();  // 보여줄 날짜 (년,월)
  var showItems;
  List<AlarmRecord> items = [];


  @override
  void onInit() async {
    items = instance();
    showItems = getMonthItem();
    super.onInit();
  }

  void plusMonth() {
    showDate = DateTime(showDate.year, showDate.month + 1);
    showItems.clear();
    showItems = getMonthItem();
    update();
  }

  void minMonth() {
    showDate = DateTime(showDate.year, showDate.month - 1);
    showItems.clear();
    showItems = getMonthItem();
    update();
  }

  String getMonth() {
    return DateFormat('yyyy.MM').format(showDate);
  }

  List<AlarmRecord> getMonthItem() {
    List<AlarmRecord> list = [];
    for (AlarmRecord row in items) {
      if (row.date.contains(getMonth())) {
        list.add(row);
      }
    }
    return list;
  }

  List<AlarmRecord> instance() {
    List<AlarmRecord> list = [];
    list.add(AlarmRecord(date: '2022.03.12',time: '14:22', count: 2));
    list.add(AlarmRecord(date: '2022.03.13',time: '11:53', count: 1));
    list.add(AlarmRecord(date: '2022.03.14',time: '15:42', count: 1));
    return list;
  }
}