import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/features/settings/domain/usecases/set_theme_usecase.dart';

class SetThemeUsecaseImpl implements SetThemeUsecase{
  final SettingsRepository repository;

  SetThemeUsecaseImpl({required this.repository});
  
  @override
  Future<bool> call(bool isDark) {
    return repository.setTheme(isDark);
  }
}