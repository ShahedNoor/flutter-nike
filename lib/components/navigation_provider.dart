import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  final List<String> _titles = ["NIKE", "My Cart", "Checkout"];

  int get selectedIndex => _selectedIndex;
  String get currentTitle => _titles[_selectedIndex];

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
