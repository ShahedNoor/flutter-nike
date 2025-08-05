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
      builder: (context, productsProvider, child) {
        final cartItems = productsProvider.userCart;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                        fontSize: 16,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Total: \$${cartItems.entries.fold<double>(0, (sum, entry) => sum + (entry.key.pricing.basePrice * entry.value)).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width >= 600
                          ? 600
                          : MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        color: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        onPressed: onPayNow,
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
