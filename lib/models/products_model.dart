class ProductsModel {
  final int id;
  final String name;
  final String price;
  final String imagePath;
  final String description;
  final int? stockQuantity;

  ProductsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    this.stockQuantity,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toString(),
      imagePath: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['src']
          : '',
      description: json['description'] ?? '',
      stockQuantity: json['stock_quantity'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          imagePath == other.imagePath;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ price.hashCode ^ imagePath.hashCode;
}
