import 'package:flutter_movies/core/data/database/database_helper.dart';
import 'package:flutter_movies/core/data/database/fields/movie_fields.dart';
import 'package:flutter_movies/core/data/models/movie_model.dart';
import 'package:sqflite/sqlite_api.dart';

class MovieDao {
  final DatabaseHelper databaseHelper;

  MovieDao({required this.databaseHelper});

  Future<void> insertMovies(List<MovieModel> movies) async {
    final database = await databaseHelper.database;
    for (var movie in movies) {
      final map = movie.toMap();
      await database.insert(
        MovieFields.tableName,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<MovieModel>> getMoviesByIds(List<int> movieIds) async {
    final database = await databaseHelper.database;

    if (movieIds.isEmpty) {
      return [];
    }

    final placeholders = List.filled(movieIds.length, '?').join(', ');

    final List<Map<String, dynamic>> maps = await database.query(
      MovieFields.tableName,
      where: 'id IN ($placeholders)',
      whereArgs: movieIds,
    );

    return List.generate(maps.length, (i) {
      return MovieModel.fromMap(maps[i]);
    });
  }

  Future<MovieModel> getMovieById(int id) async {
    final database = await databaseHelper.database;

    final List<Map<String, dynamic>> maps = await database.query(
      MovieFields.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return MovieModel.fromMap(maps.first);
  }
}