import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'About',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width >= 600
                    ? 600
                    : MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  "This minimal e-commerce application, developed by Shahed Noor, is designed to streamline your frontend development process, allowing you to focus on the core aspects of your business. Simply connect this app to your backend, and you'll be ready to go. Best of luck! 🤍",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
