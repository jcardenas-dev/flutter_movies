
import 'package:flutter_movies/core/data/datasources/settings_local_datasource.dart';
import 'package:flutter_movies/core/data/repositories/settings_repository_impl.dart';
import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingLocalDataSource extends Mock implements SettingsLocalDatasource {}

void main(){
  late SettingsRepository settingsRepository;
  late MockSettingLocalDataSource mockSettingsLocalDatasource;

  setUp(() {
    mockSettingsLocalDatasource = MockSettingLocalDataSource();
    settingsRepository = SettingsRepositoryImpl(
      settingsLocalDatasource: mockSettingsLocalDatasource
    );
  });

  test('should return language from local datasource', () async {
    const tLanguage = 'en-US';

    // Arrange
    when(() => mockSettingsLocalDatasource.getLanguage())
      .thenAnswer((_) async => tLanguage);

    // Act
    final result = await settingsRepository.getLanguage();

    // Assert
    expect(result, tLanguage);
    verify(() => mockSettingsLocalDatasource.getLanguage()).called(1);
  });

  test('should return isDarkTheme from local datasource', () async {
    const tIsDarkTheme = true;

    // Arrange
    when(() => mockSettingsLocalDatasource.isDarkTheme())
      .thenAnswer((_) async => tIsDarkTheme);

    // Act
    final result = await settingsRepository.isDarkTheme();

    // Assert
    expect(result, tIsDarkTheme);
    verify(() => mockSettingsLocalDatasource.isDarkTheme()).called(1);
  });

  test('should save language to local datasource', () async {
    const tLangCode = 'es-MX';
    const tResult = true;

    // Arrange
    when(() => mockSettingsLocalDatasource.saveLanguage(any()))
      .thenAnswer((_) async => tResult);

    // Act
    final result = await settingsRepository.saveLanguage(tLangCode);

    // Assert
    expect(result, tResult);
    verify(() => mockSettingsLocalDatasource.saveLanguage(any())).called(1);
  });

  test('should set theme to local datasource', () async {
    const tIsDark = false;
    const tResult = true;

    // Arrange
    when(() => mockSettingsLocalDatasource.setTheme(any()))
      .thenAnswer((_) async => tResult);

    // Act
    final result = await settingsRepository.setTheme(tIsDark);

    // Assert
    expect(result, tResult);
    verify(() => mockSettingsLocalDatasource.setTheme(any())).called(1);
  });
}