import 'category.dart';
import 'inventory.dart';
import 'media.dart';
import 'pricing.dart';
import 'status.dart';
import 'timestamps.dart';

class Product {
  final String id;
  final String name;
  final String brand;
  final String description;
  final String shortDescription;
  final Pricing pricing;
  final Media media;
  final Category category;
  final Inventory inventory;
  final Status status;
  final Timestamps timestamps;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.shortDescription,
    required this.pricing,
    required this.media,
    required this.category,
    required this.inventory,
    required this.status,
    required this.timestamps,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
      shortDescription: json['shortDescription'],
      pricing: Pricing.fromJson(json['pricing']),
      media: Media.fromJson(json['media']),
      category: Category.fromJson(json['category']),
      inventory: Inventory.fromJson(json['inventory']),
      status: Status.fromJson(json['status']),
      timestamps: Timestamps.fromJson(json['timestamps']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'description': description,
      'shortDescription': shortDescription,
      'pricing': pricing.toJson(),
      'media': media.toJson(),
      'category': category.toJson(),
      'inventory': inventory.toJson(),
      'status': status.toJson(),
      'timestamps': timestamps.toJson(),
    };
  }
}
