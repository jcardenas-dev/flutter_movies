import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/events/setting_events.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/settings_bloc.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/states/setting_states.dart';
import 'package:flutter_movies/l10n/app_localizations.dart';
import 'package:flutter_movies/main.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SettingsBloc>(),
      child: _SettingsPageState(),
    );
  }
  
}

class _SettingsPageState extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SettingsBloc>(context).add(LoadSettings());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('navBarSettingsTitle')),
      ),
      body: BlocBuilder<SettingsBloc, SettingState> (
        builder: (context, state) {

          String langValue = localizations.translate('englishLabel');
          String themeValue = localizations.translate('lightThemeLabel');
          if (state is SettingLoaded) {
            logger.d(state);
            if (state.langCode == 'es') {
              langValue = localizations.translate('spanishLabel');
            } else {
              langValue = localizations.translate('englishLabel');
            }
            if (state.isDark) {
              themeValue = localizations.translate('darkThemeLabel');
            } else {
              themeValue = localizations.translate('lightThemeLabel');
            }
          }

          return ListView(
            children: [
              ListTile(
                title: Text(localizations.translate('themeLabel')),
                subtitle: Text(localizations.translate('optionsTheme')),
                trailing: DropdownButton<String>(
                  value: themeValue, // Valor actual
                  onChanged: (String? newValue) {
                    BlocProvider.of<SettingsBloc>(context).add(ChangeTheme(isDark: newValue == 'Dark' || newValue == 'Oscuro' ));
                  },
                  items: <String>[
                    localizations.translate('lightThemeLabel'), 
                    localizations.translate('darkThemeLabel')
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              ListTile(
                title: Text(localizations.translate('languageLabel')),
                subtitle: Text(localizations.translate('selectLanguageLabel')),
                trailing: DropdownButton<String>(
                  value: langValue,
                  onChanged: (String? newValue) {
                    // Lógica para manejar la selección del idioma
                    
                    final langCode = newValue == localizations.translate('englishLabel') ? 'en' : 'es';
                    BlocProvider.of<SettingsBloc>(context).add(ChangeLanguage(langCode));
                  },
                  items: <String>[
                    localizations.translate('englishLabel'), 
                    localizations.translate('spanishLabel')
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )
            ],
          );
        }
      )
    );
  }
}
