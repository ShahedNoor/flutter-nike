import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nike/firebase_options.dart';
import 'package:provider/provider.dart';

import 'components/navigation_provider.dart';
import 'providers/products_provider.dart';
import 'theme/theme.dart';
import 'theme/theme_provider.dart';
import 'widgets/intro_decider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<ProductsProvider>(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
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
      home: const IntroDecider(),
    );
  }
}
