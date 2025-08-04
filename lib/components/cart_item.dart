import 'package:flutter/material.dart';
import 'package:nike/data/products.dart';
import 'package:nike/models/products_model.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final ProductsModel productsModel;

  const CartItem({super.key, required this.productsModel, required int quantity});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // Remove item from cart
  void removeItemFromCart() {
    Provider.of<Products>(context, listen: false)
        .removeFromCart(widget.productsModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: ListTile(
        leading: Image.asset(widget.productsModel.imagePath),
        title: Text(widget.productsModel.name.toUpperCase()),
        subtitle: Text('\$${widget.productsModel.price}'),
        trailing: IconButton(
          onPressed: removeItemFromCart,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
