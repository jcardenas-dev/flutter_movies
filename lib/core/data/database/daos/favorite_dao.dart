import 'package:flutter_movies/core/data/database/database_helper.dart';
import 'package:flutter_movies/core/data/database/fields/favorite_fields.dart';
import 'package:flutter_movies/main.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDao {
  final DatabaseHelper databaseHelper;

  FavoriteDao({required this.databaseHelper});

  Future<void> insertFavorite(int movieId) async {
    final database = await databaseHelper.database;
    await database.insert(
      FavoriteFields.tableName, 
      {FavoriteFields.id: movieId},
      conflictAlgorithm: ConflictAlgorithm.replace
      );
  }

  Future<void> deleteFavorite(int movieId) async {
    final database = await databaseHelper.database;
    await database.delete(
      FavoriteFields.tableName,
      where: '${FavoriteFields.id} = ?',
      whereArgs: [movieId]
    );
  }

  Future<List<int>> getFavoriteIds() async {
    final database = await databaseHelper.database;
    final List<Map<String, dynamic>> favoriteIds = await database.query(
      FavoriteFields.tableName
    );

    final List<int> movieIds = favoriteIds.map((row) => row[FavoriteFields.id] as int).toList();
    return movieIds;
  }

}