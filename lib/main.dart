import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movies/core/di/injection.dart';
import 'package:flutter_movies/features/home/pages/home_page.dart';
import 'package:flutter_movies/features/now_playing/pages/now_playing_page.dart';
import 'package:flutter_movies/features/popular_movies/di/injection.dart';
import 'package:flutter_movies/features/popular_movies/presentation/pages/popular_movies_page.dart';
import 'package:flutter_movies/features/settings/pages/settings_page.dart';
import 'package:logger/web.dart';

final logger = Logger();

void main() async {
  await dotenv.load(fileName: ".env");
  setup();
  setupPopularMoviesInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Color de fondo del BottomNavigationBar
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        )
      ),
      home: MainPage(),
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
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Populares',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            label: 'Reproduciendo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuraciones',
          ),
        ],
      ),
    );
  }
}
