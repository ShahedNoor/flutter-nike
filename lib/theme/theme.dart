import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    onSurface: Colors.grey.shade900,
    primary: Colors.grey.shade700,
    onPrimary: Colors.grey.shade400,
    secondary: Colors.grey.shade50,
    onSecondary: Colors.grey.shade200,
  ),
).copyWith(
  textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Supermolot'),
);

final ThemeData darkMode = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    onSurface: Colors.grey.shade50,
    primary: Colors.grey.shade100,
    onPrimary: Colors.grey.shade400,
    secondary: Colors.grey.shade700,
    onSecondary: Colors.grey.shade800,
  ),
  textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Supermolot'),
);
