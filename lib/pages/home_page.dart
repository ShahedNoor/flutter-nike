import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/my_nav_bar.dart';
import 'about_page.dart';
import 'cart_page.dart';
import 'checkout_page.dart';
import 'settings_page.dart';
import 'shop_page.dart';
import 'show_user_menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void bottomBarNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const ShopPage(),
      CartPage(onPayNow: () => bottomBarNavigation(2)),
      const CheckoutPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
                  bottomBarNavigation,
                ),
              );
            },
          ),
        ),
        title: Text(
          'NIKE',
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
            onPressed: () {
              // Handle notification action
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => ShowUserMenuPage.show(
                context,
                bottomBarNavigation,
              ),
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                radius: 16,
              ),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyNavBar(
        onTabChange: (index) => bottomBarNavigation(index),
        selectedIndex: _selectedIndex,
      ),
    );
  }
}