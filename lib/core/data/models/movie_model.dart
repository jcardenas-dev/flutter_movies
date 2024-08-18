import 'package:flutter_movies/core/data/database/fields/movie_fields.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';

class MovieModel {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
    );
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      adult: map[MovieFields.adult] == 1, // Asumiendo que 1 es true y 0 es false
      backdropPath: map[MovieFields.backdropPath],
      genreIds: List<int>.from(map[MovieFields.genreIds] ?? []),
      id: map[MovieFields.id],
      originalLanguage: map[MovieFields.originalLanguage],
      originalTitle: map[MovieFields.originalTitle],
      overview: map[MovieFields.overview],
      popularity: (map[MovieFields.popularity] as num).toDouble(),
      posterPath: map[MovieFields.posterPath],
      releaseDate: map[MovieFields.releaseDate],
      title: map[MovieFields.title],
      video: map[MovieFields.video] == 1, // Asumiendo que 1 es true y 0 es false
      voteAverage: (map[MovieFields.voteAverage] as num).toDouble(),
      voteCount: map[MovieFields.voteCount]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      MovieFields.adult: adult ? 1 : 0,
      MovieFields.backdropPath: backdropPath,
      MovieFields.genreIds: genreIds.join(','), // Almacenamos como una cadena
      MovieFields.id: id,
      MovieFields.originalLanguage: originalLanguage,
      MovieFields.originalTitle: originalTitle,
      MovieFields.overview: overview,
      MovieFields.popularity: popularity,
      MovieFields.posterPath: posterPath,
      MovieFields.releaseDate: releaseDate,
      MovieFields.title: title,
      MovieFields.video: video ? 1 : 0,
      MovieFields.voteAverage: voteAverage,
      MovieFields.voteCount: voteCount,
    };
  }

  Movie toDomain(bool isFavorite) {
    return Movie(
      id: id, 
      title: title, 
      overview: overview, 
      posterPath: 'https://image.tmdb.org/t/p/w500${posterPath}', 
      backdropPath: backdropPath ?? '', 
      voteAverage: voteAverage, 
      releaseDate: releaseDate,
      isFavorite: isFavorite
    );
  }

}
