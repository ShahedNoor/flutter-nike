import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;

  const MyNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Theme.of(context).colorScheme.onPrimary,
        activeColor: Theme.of(context).colorScheme.primary,
        tabBackgroundColor: Theme.of(context).colorScheme.secondary,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Shop',
          ),
          GButton(
            icon: Icons.shopping_bag_rounded,
            text: 'Cart',
          ),
        ],
      ),
    );
  }
}
