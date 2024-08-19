import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/features/settings/domain/usecases/is_dark_usecase.dart';

class IsDarkUsecaseImpl implements IsDarkUsecase{
  final SettingsRepository repository;

  IsDarkUsecaseImpl({required this.repository});

  @override
  Future<bool> call() {
    return repository.isDarkTheme();
  }
}