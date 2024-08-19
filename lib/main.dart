import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_movies/core/di/injection.dart';
import 'package:flutter_movies/features/home/di/injection.dart';
import 'package:flutter_movies/features/home/presentation/pages/home_page.dart';
import 'package:flutter_movies/features/now_playing/di/injection.dart';
import 'package:flutter_movies/features/settings/di/injection.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/notifier/language_notifier.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/notifier/theme_notifier.dart';
import 'package:flutter_movies/features/now_playing/presentation/pages/now_playing_page.dart';
import 'package:flutter_movies/features/popular_movies/di/injection.dart';
import 'package:flutter_movies/features/popular_movies/presentation/pages/popular_movies_page.dart';
import 'package:flutter_movies/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter_movies/l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';

final logger = Logger();

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    logger.e(e);
  }
  setup();
  setupHomeMoviesInjection();
  setupPopularMoviesInjection();
  setupNowPopularMoviesInjection();
  setupSettingsInjection();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetIt.I<ThemeNotifier>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<LanguageNotifier>())
      ],
      child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier, LanguageNotifier>(
      builder: (context, themeNotifier, languageNotifier, child) {
        return MaterialApp(
          title: 'Movie App',
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', '')
          ],
          locale: languageNotifier.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white, // Color de fondo del BottomNavigationBar
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            )
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark, // Define que es un tema oscuro
            primarySwatch: Colors.blue, // Mantiene el mismo primarySwatch
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black, // Color de fondo del BottomNavigationBar en modo oscuro
              selectedItemColor: Colors.blueAccent, // Color del ítem seleccionado
              unselectedItemColor: Colors.grey, // Color del ítem no seleccionado
            ),
          ),
          themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: MainPage(),
        );
      }
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const PopularMoviesPage(),
    NowPlayingPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: localizations.translate('bottomBarHomeTitle'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: localizations.translate('bottomBarPopularTitle'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.play_circle_filled),
            label: localizations.translate('bottomBarNowPlayingTitle'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: localizations.translate('bottomBarSettingsTitle'),
          ),
        ],
      ),
    );
  }
}
