import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/my_nav_bar.dart';
import 'about_page.dart';
import 'cart_page.dart';
import 'checkout_page.dart';
import 'settings_page.dart';
import 'shop_page.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: MyNavBar(
        onTabChange: (index) => bottomBarNavigation(index),
        selectedIndex: _selectedIndex,
      ),
      appBar: AppBar(
        title: Text(
          'NIKE',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            // Logo
            DrawerHeader(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  height: 80,
                  width: 80,
                  'https://gymjoy.gg/wp-content/uploads/2025/03/gymjoy-favicon.png',
                ),
              ),
            ),

            // Navigation button
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        bottomBarNavigation(0);
                      },
                      leading: Icon(
                        Icons.home,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'shop'.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        bottomBarNavigation(1);
                      },
                      leading: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'cart'.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.settings,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'settings'.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutPage(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.info,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'about'.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
              child: ListTile(
                onTap: () {
                  SystemNavigator.pop(); // This will exit the app
                },
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'exit'.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
