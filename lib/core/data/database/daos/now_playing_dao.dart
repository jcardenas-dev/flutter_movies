import 'package:flutter_movies/core/data/database/database_helper.dart';
import 'package:flutter_movies/core/data/database/fields/now_playing_fields.dart';
import 'package:sqflite/sqflite.dart';

class NowPlayingDao {
  final DatabaseHelper databaseHelper;

  NowPlayingDao({required this.databaseHelper});

  Future<void> insertNowPlaying(List<int> movieIds) async {
    final database = await databaseHelper.database;
    for (var movieId in movieIds) {
      await database.insert(
        NowPlayingFields.tableName, 
        {NowPlayingFields.id: movieId},
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    }
  }

  Future<void> deleteAll() async {
    final database = await databaseHelper.database;
    await database.delete(
      NowPlayingFields.tableName
    );
  }

  Future<List<int>> getNowPlayingIds() async {
    final database = await databaseHelper.database;
    final List<Map<String, dynamic>> nowPlayingIds = await database.query(
      NowPlayingFields.tableName
    );

    final List<int> movieIds = nowPlayingIds.map((row) => row[NowPlayingFields.id] as int).toList();
    return movieIds;
  }
}