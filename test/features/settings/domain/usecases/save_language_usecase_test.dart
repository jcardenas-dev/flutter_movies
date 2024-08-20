import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:flutter_movies/features/settings/presentation/usecases/save_language_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late SaveLanguageUsecase usecase;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = SaveLanguageUsecaseImpl(repository: mockSettingsRepository);
  });

  const tLangCode = 'es';

  test('should save the language code using the repository', () async {
    // Arrange
    when(() => mockSettingsRepository.saveLanguage(tLangCode))
        .thenAnswer((_) async => true);

    // Act
    final result = await usecase.call(tLangCode);

    // Assert
    expect(result, true);
    verify(() => mockSettingsRepository.saveLanguage(tLangCode)).called(1);
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}