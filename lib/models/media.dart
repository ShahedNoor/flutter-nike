class Media {
  final String primaryImage;
  final List<String> images;
  final String thumbnailImage;

  Media({
    required this.primaryImage,
    required this.images,
    required this.thumbnailImage,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      primaryImage: json['primaryImage'],
      images: List<String>.from(json['images']),
      thumbnailImage: json['thumbnailImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primaryImage': primaryImage,
      'images': images,
      'thumbnailImage': thumbnailImage,
    };
  }
}
