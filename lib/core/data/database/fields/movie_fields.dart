class MovieFields {
  static const String tableName = 'movies';

  static const String id = 'id';
  static const String adult = 'adult';
  static const String backdropPath = 'backdrop_path';
  static const String genreIds = 'genre_ids';
  static const String originalLanguage = 'original_language';
  static const String originalTitle = 'original_title';
  static const String overview = 'overview';
  static const String popularity = 'popularity';
  static const String posterPath = 'poster_path';
  static const String releaseDate = 'release_date';
  static const String title = 'title';
  static const String video = 'video';
  static const String voteAverage = 'vote_average';
  static const String voteCount = 'vote_count';
}

// SQL statement to create the movies table
const createMoviesTable = '''
  CREATE TABLE ${MovieFields.tableName} (
    ${MovieFields.id} INTEGER PRIMARY KEY,
    ${MovieFields.adult} BOOLEAN,
    ${MovieFields.backdropPath} TEXT,
    ${MovieFields.genreIds} TEXT,
    ${MovieFields.originalLanguage} TEXT,
    ${MovieFields.originalTitle} TEXT,
    ${MovieFields.overview} TEXT,
    ${MovieFields.popularity} REAL,
    ${MovieFields.posterPath} TEXT,
    ${MovieFields.releaseDate} TEXT,
    ${MovieFields.title} TEXT,
    ${MovieFields.video} BOOLEAN,
    ${MovieFields.voteAverage} REAL,
    ${MovieFields.voteCount} INTEGER
  )
''';