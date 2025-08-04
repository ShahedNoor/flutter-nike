import 'package:flutter/material.dart';

import '../models/products_model.dart';

class ProductTile extends StatelessWidget {
  final ProductsModel productsModel;
  final void Function()? onTap;

  const ProductTile({
    super.key,
    required this.productsModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 289,
      margin: const EdgeInsets.only(left: 25.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shoe picture
          Container(
            height: 240,
            width: 240,
            margin: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ClipRRect(
              child: Image.network(productsModel.imagePath, fit: BoxFit.fill),
            ),
          ),

          // Product name
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              productsModel.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          // Description
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(children: [Text('5-in-1 Full Power Combo')]),
          ),

          // Stock status
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Text("Stock Left: ${productsModel.stockQuantity.toString()}"),
              ],
            ),
          ),

          // Price and add to cart button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '৳${productsModel.price}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
