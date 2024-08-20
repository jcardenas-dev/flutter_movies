import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/features/settings/domain/usecases/set_theme_usecase.dart';
import 'package:flutter_movies/features/settings/presentation/usecases/set_theme_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late SetThemeUsecase setThemeUsecase;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    setThemeUsecase = SetThemeUsecaseImpl(repository: mockSettingsRepository);
  });

  test('should call setTheme on repository with correct value', () async {
    // Arrange
    const tIsDark = true;
    when(() => mockSettingsRepository.setTheme(tIsDark)).thenAnswer((_) async => true);

    // Act
    final result = await setThemeUsecase.call(tIsDark);

    // Assert
    verify(() => mockSettingsRepository.setTheme(tIsDark)).called(1);
    expect(result, true);
  });
}