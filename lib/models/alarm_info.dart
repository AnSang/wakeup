class AlarmInfo {
  final String time;
  var day = List.filled(7, false);
  var isRun = false;

  AlarmInfo(this.time, this.day, this.isRun);
}