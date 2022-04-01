class AlarmRecord {
  final String date;  // 수면 날짜
  final String time;  // 수면 시간
  String? document;

  AlarmRecord({
    required this.date,
    required this.time
  });

  AlarmRecord.fromJson(Map<String, dynamic> json)
      : this(
      date: json['date']! as String,
      time: json['time']! as String
  );

  Map<String, dynamic> toJson() {
    return {
      'date' : date,
      'time' : time
    };
  }
}