import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_nav_bar.dart';
import '../components/navigation_provider.dart';
import 'cart_page.dart';
import 'checkout_page.dart';
import 'shop_page.dart';
import 'show_user_menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const ShopPage(),
      CartPage(onPayNow: () => context.read<NavigationProvider>().setIndex(2)),
      const CheckoutPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.network(
            'https://raw.githubusercontent.com/ShahedNoor/flutter-nike/refs/heads/main/assets/images/logo/nike.png',
            errorBuilder: (context, error, stackTrace) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => ShowUserMenuPage.show(
                  context,
                  (index) => navProvider.setIndex(index),
                ),
              );
            },
          ),
        ),
        title: Text(
          navProvider.currentTitle,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => ShowUserMenuPage.show(
                context,
                (index) => navProvider.setIndex(index),
              ),
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1170&auto=format&fit=crop',
                ),
                radius: 16,
              ),
            ),
          ),
        ],
      ),
      body: _pages[navProvider.selectedIndex],
      bottomNavigationBar: MyNavBar(
        onTabChange: (index) => navProvider.setIndex(index),
        selectedIndex: navProvider.selectedIndex,
      ),
    );
  }
}
