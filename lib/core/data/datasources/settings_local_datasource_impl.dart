import 'package:flutter_movies/core/data/datasources/settings_local_datasource.dart';
import 'package:flutter_movies/core/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDatasourceImpl implements SettingsLocalDatasource{

  @override
  Future<bool> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(AppConstants.LANG_CODE, langCode);
  }

  @override
  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.LANG_CODE) ?? 'en';
  }

  @override
  Future<bool> isDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.THEME) ?? false;
  }

  @override
  Future<bool> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(AppConstants.THEME, isDark);
  }

}