import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page.dart';
import '../pages/intro_page.dart';

class IntroDecider extends StatefulWidget {
  const IntroDecider({super.key});

  @override
  State<IntroDecider> createState() => _IntroDeciderState();
}

class _IntroDeciderState extends State<IntroDecider> {
  bool? hasSeenIntro;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('hasSeenIntro') ?? false;

    // Delay for visual loading effect if needed
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      hasSeenIntro = seen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasSeenIntro == null) {
      // Still checking
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return hasSeenIntro! ? const HomePage() : const IntroPage();
  }
}
