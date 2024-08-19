// Define los eventos del BLoC
import 'package:equatable/equatable.dart';

abstract class SettingEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingEvents {}

class ChangeLanguage extends SettingEvents {
  final String langCode;

  ChangeLanguage(this.langCode);
}

class ChangeTheme extends SettingEvents {
  final bool isDark;

  ChangeTheme({required this.isDark});
}