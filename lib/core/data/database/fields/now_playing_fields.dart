class NowPlayingFields {
  static const String tableName = 'now_playing_movies';

  static const String id = 'id';
}

// SQL statement to create the movies table
const String createNowPlayingMoviesTable = '''
  CREATE TABLE ${NowPlayingFields.tableName} (
    ${NowPlayingFields.id} INTEGER PRIMARY KEY
  )
''';