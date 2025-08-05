class Category {
  final String main;
  final String sub;
  final String type;
  final String gender;
  final String ageGroup;

  Category({
    required this.main,
    required this.sub,
    required this.type,
    required this.gender,
    required this.ageGroup,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      main: json['main'],
      sub: json['sub'],
      type: json['type'],
      gender: json['gender'],
      ageGroup: json['ageGroup'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': main,
      'sub': sub,
      'type': type,
      'gender': gender,
      'ageGroup': ageGroup,
    };
  }
}
