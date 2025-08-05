class Status {
  final bool isActive;
  final bool isPublished;
  final bool isFeatured;
  final bool isNewArrival;
  final bool isBestseller;
  final String visibility;

  Status({
    required this.isActive,
    required this.isPublished,
    required this.isFeatured,
    required this.isNewArrival,
    required this.isBestseller,
    required this.visibility,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      isActive: json['isActive'],
      isPublished: json['isPublished'],
      isFeatured: json['isFeatured'],
      isNewArrival: json['isNewArrival'],
      isBestseller: json['isBestseller'],
      visibility: json['visibility'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'isPublished': isPublished,
      'isFeatured': isFeatured,
      'isNewArrival': isNewArrival,
      'isBestseller': isBestseller,
      'visibility': visibility,
    };
  }
}
