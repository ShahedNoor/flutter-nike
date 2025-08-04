import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cart_item.dart';
import '../providers/products_provider.dart';

class CartPage extends StatelessWidget {
  final VoidCallback onPayNow;
  const CartPage({super.key, required this.onPayNow});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, value, child) {
        final cartItems =
            Provider.of<ProductsProvider>(context, listen: false).getUserCart();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Cart',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              if (cartItems.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'Oh, no. Your cart is empty!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final entry = cartItems.entries.elementAt(index);
                      return CartItem(
                        productsModel: entry.key,
                        quantity: entry.value,
                      );
                    },
                  ),
                ),
              if (cartItems.isNotEmpty)
                Column(
                  children: [
                    Text(
                      'Total: ৳${cartItems.entries.map((entry) => double.tryParse(entry.key.price)! * entry.value).reduce((a, b) => a + b).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 60,
                        width:
                            MediaQuery.sizeOf(context).width >= 600
                                ? 600
                                : MediaQuery.sizeOf(context).width,
                        child: MaterialButton(
                          color: Theme.of(context).colorScheme.onSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          onPressed: onPayNow,
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
            ],
          ),
        );
      },
    );
  }
}
