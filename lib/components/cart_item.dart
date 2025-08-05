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
        color: Theme.of(context).colorScheme.secondaryContainer,
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
        subtitle: Text(
          'Price: \$${productsModel.pricing.basePrice.toStringAsFixed(2)}\nQuantity: $quantity',
        ),
        isThreeLine: true,
        trailing: SizedBox(
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  productsProvider.removeFromCart(productsModel);
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text('$quantity', style: const TextStyle(fontSize: 16)),
              IconButton(
                onPressed: () {
                  productsProvider.addItemToCart(productsModel);
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
              IconButton(
                onPressed: () {
                  productsProvider.removeProductCompletely(productsModel);
                },
                icon: const Icon(Icons.delete_forever),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
