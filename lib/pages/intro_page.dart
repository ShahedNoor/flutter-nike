import 'package:flutter/material.dart';
import 'package:nike/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width >= 600
              ? 600
              : MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    'assets/images/logo/nike.png',
                    height: 240,
                    width: 240,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),

                // Title
                const Text(
                  'Nike',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                // Sub title
                Text(
                  'Brand new sneakers and custom kicks made with premium quality',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),

                // Start now button
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Shop Now',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
