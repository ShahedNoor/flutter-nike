class Pricing {
  final double basePrice;
  final double salePrice;
  final String currency;
  final int discountPercentage;
  final bool isOnSale;
  final SalePeriod salePeriod;

  Pricing({
    required this.basePrice,
    required this.salePrice,
    required this.currency,
    required this.discountPercentage,
    required this.isOnSale,
    required this.salePeriod,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      basePrice: json['basePrice'].toDouble(),
      salePrice: json['salePrice'].toDouble(),
      currency: json['currency'],
      discountPercentage: json['discountPercentage'],
      isOnSale: json['isOnSale'],
      salePeriod: SalePeriod.fromJson(json['salePeriod']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'basePrice': basePrice,
      'salePrice': salePrice,
      'currency': currency,
      'discountPercentage': discountPercentage,
      'isOnSale': isOnSale,
      'salePeriod': salePeriod.toJson(),
    };
  }
}

class SalePeriod {
  final String startDate;
  final String endDate;

  SalePeriod({required this.startDate, required this.endDate});

  factory SalePeriod.fromJson(Map<String, dynamic> json) {
    return SalePeriod(startDate: json['startDate'], endDate: json['endDate']);
  }

  Map<String, dynamic> toJson() {
    return {'startDate': startDate, 'endDate': endDate};
  }
}
