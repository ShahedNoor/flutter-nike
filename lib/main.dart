import 'package:flutter/material.dart';
import 'package:nike/data/products.dart';
import 'package:nike/pages/intro_page.dart';
import 'package:nike/theme/theme.dart';
import 'package:nike/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<Products>(create: (_) => Products()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: darkMode,
      home: const IntroPage(),
    );
  }
}
