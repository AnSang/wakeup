class UserInfoLocal {
  String name;
  double volume;

  UserInfoLocal({
    required this.name,
    required this.volume
  });

  UserInfoLocal.fromJson(Map<String, Object?> json)
      : this(
      name: json['name']! as String,
      volume: json['volume']! as double
  );

  Map<String, Object?> toJson() {
    return {
      'name' : name,
      'volume' : volume
    };
  }

  @override
  String toString() {
    return '"UserInfoLocal" : { "name": $name, "volume": $volume}';
  }
}