class AlarmInfo {
  int index;
  String time;
  List<dynamic> day;
  bool isRun = false;
  String? document;

  AlarmInfo({
    required this.index,
    required this.time,
    required this.day,
    required this.isRun
  });

  AlarmInfo.fromJson(Map<String, Object?> json)
      : this(
        index: json['index']! as int,
        time: json['time']! as String,
        day: json['day']! as List<dynamic>,
        isRun: json['isRun']! as bool
  );

  Map<String, Object?> toJson() {
    return {
      'index' : index,
      'time' : time,
      'day' : day,
      'isRun' : isRun
    };
  }

  @override
  String toString() {
    return '"AlarmInfo" : { "index": $index, "time": $time, "day": $day, "isRun" : $isRun}';
  }
}