abstract class SettingsLocalDatasource {
  Future<bool> saveLanguage(String langCode);
  Future<String> getLanguage();
  Future<bool> isDarkTheme();
  Future<bool> setTheme(bool isDark);
}