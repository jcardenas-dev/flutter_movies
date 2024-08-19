import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/features/settings/domain/usecases/is_dark_usecase.dart';
import 'package:flutter_movies/features/settings/presentation/usecases/is_dark_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late IsDarkUsecase usecase;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = IsDarkUsecaseImpl(repository: mockSettingsRepository);
  });

  test('debería retornar true cuando el tema oscuro está activado', () async {
    // Arrange
    when(() => mockSettingsRepository.isDarkTheme()).thenAnswer((_) async => true);

    // Act
    final result = await usecase();

    // Assert
    expect(result, true);
    verify(() => mockSettingsRepository.isDarkTheme()).called(1);
  });

  test('debería retornar false cuando el tema oscuro está desactivado', () async {
    // Arrange
    when(() => mockSettingsRepository.isDarkTheme()).thenAnswer((_) async => false);

    // Act
    final result = await usecase();

    // Assert
    expect(result, false);
    verify(() => mockSettingsRepository.isDarkTheme()).called(1);
  });
}