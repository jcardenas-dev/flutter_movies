import 'package:flutter_movies/core/data/datasources/settings_local_datasource.dart';
import 'package:flutter_movies/core/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {

  final SharedPreferences prefs;

  SettingsLocalDatasourceImpl({required this.prefs});

  @override
  Future<bool> saveLanguage(String langCode) async {
    return prefs.setString(AppConstants.LANG_CODE, langCode);
  }

  @override
  Future<String> getLanguage() async {
    return prefs.getString(AppConstants.LANG_CODE) ?? 'en';
  }

  @override
  Future<bool> isDarkTheme() async {
    return prefs.getBool(AppConstants.THEME) ?? false;
  }

  @override
  Future<bool> setTheme(bool isDark) async {
    return prefs.setBool(AppConstants.THEME, isDark);
  }

}