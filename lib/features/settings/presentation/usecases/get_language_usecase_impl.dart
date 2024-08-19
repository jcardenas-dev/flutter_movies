import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/features/settings/domain/usecases/get_language_usecase.dart';

class GetLanguageUsecaseImpl implements GetLanguageUsecase {
  final SettingsRepository repository;

  GetLanguageUsecaseImpl({required this.repository});

  @override
  Future<String> call() {
    return repository.getLanguage();
  }
}