class UserInfoLocal {
  String name;      /// 닉네임
  double volume;    /// 알람 볼륨
  int count;        /// 수면기록 횟수

  UserInfoLocal({
    required this.name,
    required this.volume,
    required this.count
  });

  UserInfoLocal.fromJson(Map<String, Object?> json)
      : this(
      name: json['name']! as String,
      volume: json['volume']! as double,
      count: json['count']! as int,
  );

  Map<String, Object?> toJson() {
    return {
      'name' : name,
      'volume' : volume,
      'count' : count
    };
  }

  @override
  String toString() {
    return '"UserInfoLocal" : { "name": $name, "volume": $volume, "count": $count}';
  }
}