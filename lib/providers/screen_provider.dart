import 'package:flutter/material.dart';

class ScreenProvider extends ChangeNotifier {
  static const int dungeonScreenIndex = 0;
  static const int partyScreenIndex = 1;
  static const int settingsScreenIndex = 2;

  int _currentScreenIndex = 0;

  int get currentScreenIndex => _currentScreenIndex;

  void changeScreen(int index) {
    _currentScreenIndex = index;
    notifyListeners();
  }
}
