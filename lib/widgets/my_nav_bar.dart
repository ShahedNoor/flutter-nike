import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class MyNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  final int selectedIndex;

  const MyNavBar({
    super.key,
    required this.onTabChange,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final cartItemCount = context.watch<ProductsProvider>().totalCartItems;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GNav(
        selectedIndex: selectedIndex,
        color: Theme.of(context).colorScheme.onPrimary,
        activeColor: Theme.of(context).colorScheme.primary,
        tabBackgroundColor: Theme.of(context).colorScheme.secondary,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        gap: 8,
        onTabChange: (value) => onTabChange!(value),
        tabs: [
          const GButton(icon: Icons.home, text: 'Shop'),
          GButton(
            text: 'Cart',
            icon: Icons.shopping_bag_rounded,
            leading: Stack(
              children: [
                const Icon(Icons.shopping_bag_rounded),
                if (cartItemCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
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