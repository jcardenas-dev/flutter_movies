import 'package:flutter_movies/core/data/datasources/settings_local_datasource_impl.dart';
import 'package:flutter_movies/core/utils/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SettingsLocalDatasourceImpl datasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = SettingsLocalDatasourceImpl(prefs: mockSharedPreferences);

    when(() => mockSharedPreferences.setBool(any(), any())).thenAnswer((_) async => true);
    when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => true);
    when(() => mockSharedPreferences.getString(AppConstants.LANG_CODE)).thenReturn('en');
    when(() => mockSharedPreferences.getBool(AppConstants.THEME)).thenReturn(false);

    SharedPreferences.setMockInitialValues({});
  });

  group('saveLanguage', () {
    test('should save language code using SharedPreferences', () async {
      // Arrange
      const tLangCode = 'es';

      // Act
      await datasource.saveLanguage(tLangCode);

      // Assert
      verify(() => mockSharedPreferences.setString(AppConstants.LANG_CODE, tLangCode)).called(1);
    });
  });

  group('getLanguage', () {
    test('should return saved language code from SharedPreferences', () async {
      // Act
      final result = await datasource.getLanguage();

      // Assert
      expect(result, 'en');
      verify(() => mockSharedPreferences.getString(AppConstants.LANG_CODE)).called(1);
    });
  });

  group('isDarkTheme', () {
    test('should return saved theme value from SharedPreferences', () async {
      // Act
      final result = await datasource.isDarkTheme();

      // Assert
      expect(result, false);
      verify(() => mockSharedPreferences.getBool(AppConstants.THEME)).called(1);
    });
  });

  group('setTheme', () {
    test('should save theme value using SharedPreferences', () async {
      // Arrange
      const tIsDark = true;

      // Act
      await datasource.setTheme(tIsDark);

      // Assert
      verify(() => mockSharedPreferences.setBool(AppConstants.THEME, tIsDark)).called(1);
    });
  });
}