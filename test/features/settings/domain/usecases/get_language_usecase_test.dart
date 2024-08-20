import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:flutter_movies/features/settings/presentation/usecases/get_language_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late GetLanguageUsecase usecase;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = GetLanguageUsecaseImpl(repository: mockSettingsRepository);
  });

  test('should return the language code from the repository', () async {
    // Arrange
    const tLanguageCode = 'en';
    when(() => mockSettingsRepository.getLanguage())
        .thenAnswer((_) async => tLanguageCode);

    // Act
    final result = await usecase.call();

    // Assert
    expect(result, tLanguageCode);
    verify(() => mockSettingsRepository.getLanguage()).called(1);
    verifyNoMoreInteractions(mockSettingsRepository);
  });

  test('should return a different language code from the repository', () async {
    // Arrange
    const tLanguageCode = 'es';
    when(() => mockSettingsRepository.getLanguage())
        .thenAnswer((_) async => tLanguageCode);

    // Act
    final result = await usecase.call();

    // Assert
    expect(result, tLanguageCode);
    verify(() => mockSettingsRepository.getLanguage()).called(1);
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}