import 'package:flutter_movies/core/data/database/fields/favorite_fields.dart';
import 'package:flutter_movies/core/data/database/fields/movie_fields.dart';
import 'package:flutter_movies/core/data/database/fields/now_playing_fields.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'movie_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(createMoviesTable);
        db.execute(createFavoriteMoviesTable);
        db.execute(createNowPlayingMoviesTable);
      },
      version: 2,
    );
  }
}