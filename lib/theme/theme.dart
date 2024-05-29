import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade700,
    onPrimary: Colors.grey.shade400,
    secondary: Colors.grey.shade50,
    onSecondary: Colors.grey.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade100,
    onPrimary: Colors.grey.shade400,
    secondary: Colors.grey.shade700,
    onSecondary: Colors.grey.shade800,
  ),
);
