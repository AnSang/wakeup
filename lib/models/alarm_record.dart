class AlarmRecord {
  final String date;
  final String time;
  final int count;

  AlarmRecord({
    required this.date,
    required this.time,
    required this.count,
  });

  AlarmRecord.fromJson(Map<String, dynamic> json)
      : this(
      date: json['date']! as String,
      time: json['time']! as String,
      count: json['count']! as int
  );

  Map<String, dynamic> toJson() {
    return {
      'date' : date,
      'time' : time,
      'count' : count
    };
  }
}