import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/notifier/language_notifier.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/notifier/theme_notifier.dart';
import 'package:flutter_movies/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:flutter_movies/features/settings/domain/usecases/is_dark_usecase.dart';
import 'package:flutter_movies/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:flutter_movies/features/settings/domain/usecases/set_theme_usecase.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/events/setting_events.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/states/setting_states.dart';
import 'package:flutter_movies/main.dart';


class SettingsBloc extends Bloc<SettingEvents, SettingState> {
  final GetLanguageUsecase getLanguageUsecase;
  final SaveLanguageUsecase saveLanguageUsecase;
  final IsDarkUsecase isDarkUsecase;
  final SetThemeUsecase setThemeUsecase;
  final ThemeNotifier themeNotifier;
  final LanguageNotifier languageNotifier;

  SettingsBloc({
    required this.getLanguageUsecase,
    required this.saveLanguageUsecase,
    required this.isDarkUsecase,
    required this.setThemeUsecase,
    required this.themeNotifier,
    required this.languageNotifier
  }): super(SettingInitial()) {
    on<LoadSettings>((event, emit) async {
       final isDark = await isDarkUsecase();
       final langCode = await getLanguageUsecase();
       logger.d('isDark: $isDark, langCode: $langCode');
       emit(SettingLoaded(langCode: langCode, isDark: isDark));
    });

    on<ChangeLanguage>((event, emit) async {
      final currentState = state as SettingLoaded;
      if (currentState.langCode != event.langCode) {
        await saveLanguageUsecase(event.langCode);
        languageNotifier.setLocale(event.langCode);
        emit(SettingLoaded(langCode: event.langCode, isDark: currentState.isDark));
      }
    });

    on<ChangeTheme>((event, emit) async {
      final currentState = state as SettingLoaded;
      if (currentState.isDark != event.isDark) {
        await setThemeUsecase(event.isDark);
        themeNotifier.toggleTheme();
        emit(SettingLoaded(langCode: currentState.langCode, isDark: event.isDark));
      }
    });
  }
}