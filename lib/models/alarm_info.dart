class AlarmInfo {
  final String time;
  final List<dynamic> day;
  bool isRun = false;

  AlarmInfo({
    required this.time,
    required this.day,
    required this.isRun
  });

  AlarmInfo.fromJson(Map<String, dynamic> json)
      : this(
        time: json['time']! as String,
        day: json['day']! as List<dynamic>,
        isRun: json['isRun']! as bool
  );

  Map<String, dynamic> toJson() {
    return {
      'time' : time,
      'day' : day,
      'isRun' : isRun
    };
  }

  @override
  String toString() {
    return '"AlarmInfo" : { "time": $time, "day": $day, "isRun" : $isRun}';
  }
}