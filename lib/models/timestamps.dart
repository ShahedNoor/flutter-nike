class Timestamps {
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String lastStockUpdate;

  Timestamps({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.lastStockUpdate,
  });

  factory Timestamps.fromJson(Map<String, dynamic> json) {
    return Timestamps(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      lastStockUpdate: json['lastStockUpdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'publishedAt': publishedAt,
      'lastStockUpdate': lastStockUpdate,
    };
  }
}
