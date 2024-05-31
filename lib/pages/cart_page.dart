import 'package:flutter/material.dart';
import 'package:nike/components/cart_item.dart';
import 'package:nike/data/products.dart';
import 'package:nike/models/products_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    void showMessage() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 2,
                ),
                const Text(
                    'User wants to pay! Connect this app to you backend'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return Consumer<Products>(
      builder: (context, value, child) {
        var cartItems = value.getUserCart();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const Text(
                'My Cart',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (cartItems.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'Oh, no. Your cart is empty!',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      ProductsModel individualProduct = cartItems[index];
                      return CartItem(
                        productsModel: individualProduct,
                      );
                    },
                  ),
                ),
              if (cartItems.isNotEmpty)
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.sizeOf(context).width >= 600
                        ? 600
                        : MediaQuery.sizeOf(context).width,
                    child: MaterialButton(
                      color: Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: showMessage,
                      child: Text(
                        'Pay Now',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
