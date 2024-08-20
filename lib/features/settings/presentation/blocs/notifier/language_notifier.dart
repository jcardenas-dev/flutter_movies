import 'package:flutter/material.dart';
import 'package:flutter_movies/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:flutter_movies/main.dart';

class LanguageNotifier with ChangeNotifier {
  final GetLanguageUsecase getLanguageUsecase;
  Locale locale = const Locale('en', ''); // Idioma por defecto

  LanguageNotifier({required this.getLanguageUsecase}) {
    loadLocale();
  }

  void setLocale(String localCode) async {
    locale = Locale(localCode, '');
    logger.d('setlocale: $localCode');
    notifyListeners();
  }

  Future<void> loadLocale() async {
    final languageCode = await getLanguageUsecase();
    locale = Locale(languageCode, '');
    notifyListeners();
  }
}