import 'package:flutter/material.dart';
import 'package:flutter_movies/features/settings/domain/usecases/is_dark_usecase.dart';
import 'package:flutter_movies/main.dart';

class ThemeNotifier with ChangeNotifier {
  final IsDarkUsecase isDarkUsecase;
  bool isDarkMode = false;

  ThemeNotifier({required this.isDarkUsecase}) {
    _loadFromPrefs();
  }

  toggleTheme() {
    isDarkMode = !isDarkMode;
    logger.d('toggleTheme: $isDarkMode');
    notifyListeners();
  }

  _loadFromPrefs() async {
    isDarkMode = await isDarkUsecase();
    notifyListeners();
  }
}