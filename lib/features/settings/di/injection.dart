import 'package:flutter_movies/core/di/injection.dart';
import 'package:flutter_movies/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:flutter_movies/features/settings/domain/usecases/set_theme_usecase.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/settings_bloc.dart';
import 'package:flutter_movies/features/settings/presentation/usecases/save_language_usecase_impl.dart';
import 'package:flutter_movies/features/settings/presentation/usecases/set_theme_usecase_impl.dart';

void setupSettingsInjection() {
  // Registrar Use Case
  sl.registerLazySingleton<SetThemeUsecase>(
    () => SetThemeUsecaseImpl(repository: sl()),
  );

  sl.registerLazySingleton<SaveLanguageUsecase>(
    () => SaveLanguageUsecaseImpl(repository: sl()),
  );

  sl.registerFactory(() => SettingsBloc(
    getLanguageUsecase: sl(),
    saveLanguageUsecase: sl(),
    isDarkUsecase: sl(),
    setThemeUsecase: sl(),
    themeNotifier: sl(),
    languageNotifier: sl()
  ));
}