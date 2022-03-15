class AlarmRecord {
  final DateTime start; // 수면 시작시간
  final DateTime end;   // 수면 종료시간
  final int count;      // 총 알람 횟수

  AlarmRecord({
    required this.start,
    required this.end,
    required this.count,
  });

  AlarmRecord.fromJson(Map<String, dynamic> json)
      : this(
      start: json['start']! as DateTime,
      end: json['end']! as DateTime,
      count: json['count']! as int
  );

  Map<String, dynamic> toJson() {
    return {
      'start' : start,
      'end' : end,
      'count' : count
    };
  }
}