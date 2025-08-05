class Inventory {
  final int totalStock;
  final int availableStock;
  final int reservedStock;
  final bool isInStock;
  final String stockStatus;
  final int lowStockThreshold;
  final bool isLowStock;
  final String sku;
  final String barcode;

  Inventory({
    required this.totalStock,
    required this.availableStock,
    required this.reservedStock,
    required this.isInStock,
    required this.stockStatus,
    required this.lowStockThreshold,
    required this.isLowStock,
    required this.sku,
    required this.barcode,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      totalStock: json['totalStock'],
      availableStock: json['availableStock'],
      reservedStock: json['reservedStock'],
      isInStock: json['isInStock'],
      stockStatus: json['stockStatus'],
      lowStockThreshold: json['lowStockThreshold'],
      isLowStock: json['isLowStock'],
      sku: json['sku'],
      barcode: json['barcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalStock': totalStock,
      'availableStock': availableStock,
      'reservedStock': reservedStock,
      'isInStock': isInStock,
      'stockStatus': stockStatus,
      'lowStockThreshold': lowStockThreshold,
      'isLowStock': isLowStock,
      'sku': sku,
      'barcode': barcode,
    };
  }
}
