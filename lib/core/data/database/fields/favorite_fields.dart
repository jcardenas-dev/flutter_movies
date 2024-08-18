class FavoriteFields {
  static const String tableName = 'favorite_movies';

  static const String id = 'id';
}

// SQL statement to create the movies table
const String createFavoriteMoviesTable = '''
  CREATE TABLE ${FavoriteFields.tableName} (
    ${FavoriteFields.id} INTEGER PRIMARY KEY
  )
''';