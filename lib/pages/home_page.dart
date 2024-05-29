import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nike/components/my_nav_bar.dart';
import 'package:nike/pages/cart_page.dart';
import 'package:nike/pages/settings_page.dart';
import 'package:nike/pages/shop_page.dart';

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

  // Pages
  final List<Widget> _pages = [
    // Shop page
    const ShopPage(),

    // Cart page
    const CartPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: MyNavBar(
        onTabChange: (index) => bottomBarNavigation(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            // Logo
            DrawerHeader(
              child: Image.asset(
                'assets/images/logo/nike.png',
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            // Navigation button
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
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
