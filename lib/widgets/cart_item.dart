import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../providers/products_provider.dart';

class CartItem extends StatefulWidget {
  final ProductsModel productsModel;
  final int quantity;

  const CartItem({
    super.key,
    required this.productsModel,
    required this.quantity,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  void addItem() {
    Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).addItemToCart(widget.productsModel);
  }

  void removeItem() {
    Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).removeFromCart(widget.productsModel);
  }

  void removeItemCompletely() {
    Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).removeProductCompletely(widget.productsModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            widget.productsModel.imagePath,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(widget.productsModel.name.toUpperCase()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('৳${widget.productsModel.price}'),
            const SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: removeItem,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(widget.quantity.toString()),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: addItem,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: removeItemCompletely,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
