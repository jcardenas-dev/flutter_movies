import 'package:flutter_movies/core/data/datasources/settings_local_datasource.dart';
import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource settingsLocalDatasource;

  SettingsRepositoryImpl({required this.settingsLocalDatasource});

  @override
  Future<String> getLanguage() {
    return settingsLocalDatasource.getLanguage();
  }

  @override
  Future<bool> isDarkTheme() {
    return settingsLocalDatasource.isDarkTheme();
  }

  @override
  Future<bool> saveLanguage(String langCode) {
    return settingsLocalDatasource.saveLanguage(langCode);
  }

  @override
  Future<bool> setTheme(bool isDark) {
    return settingsLocalDatasource.setTheme(isDark);
  }

}