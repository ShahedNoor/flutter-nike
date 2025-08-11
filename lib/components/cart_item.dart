import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';

class CartItem extends StatelessWidget {
  final Product productsModel;
  final int quantity;

  const CartItem({
    super.key,
    required this.productsModel,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            productsModel.media.thumbnailImage,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          productsModel.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$${productsModel.pricing.basePrice.toStringAsFixed(2)}'),

            SizedBox(height: 10),

            Row(
              children: [
                // Decrease quantity
                GestureDetector(
                  onTap: () {
                    productsProvider.removeProductCompletely(productsModel);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.remove,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                // Quantity text
                Text('$quantity', style: const TextStyle(fontSize: 16)),

                SizedBox(width: 10),

                // Increase quantity
                GestureDetector(
                  onTap: () {
                    productsProvider.addItemToCart(productsModel);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
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
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            productsProvider.removeProductCompletely(productsModel);
          },
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
