import 'package:equatable/equatable.dart';

abstract class SettingState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState { }

class SettingLoaded extends SettingState {
  final String langCode;
  final bool isDark;

  SettingLoaded({required this.langCode, required this.isDark});
}

class LanguageChanged extends SettingState {
  final String langCode;

  LanguageChanged(this.langCode);

  @override
  List<Object> get props => [langCode];
}

class ThemeChanged extends SettingState {
  final bool isDark;

  ThemeChanged(this.isDark);
}