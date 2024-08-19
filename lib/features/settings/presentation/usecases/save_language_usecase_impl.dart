import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/features/settings/domain/usecases/save_language_usecase.dart';

class SaveLanguageUsecaseImpl implements SaveLanguageUsecase {
  final SettingsRepository repository;

  SaveLanguageUsecaseImpl({required this.repository});

  @override
  Future<bool> call(String langCode) {
    return repository.saveLanguage(langCode);
  }
}