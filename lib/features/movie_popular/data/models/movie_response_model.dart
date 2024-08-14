import 'package:flutter_movies/features/movie_popular/data/models/movie_model.dart';
import 'package:flutter_movies/features/movie_popular/domain/entities/movie.dart';

class MovieResponseModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      page: json['page'],
      results: List<MovieModel>.from(json['results'].map((movieJson) => MovieModel.fromJson(movieJson))),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  List<Movie> toDomain() {
    return results.map((toElement) => Movie(
      id: toElement.id, 
      title: toElement.title, 
      overview: toElement.overview, 
      posterPath: toElement.posterPath, 
      backdropPath: toElement.backdropPath, 
      voteAverage: toElement.voteAverage, 
      releaseDate: toElement.releaseDate
      )
    ).toList();
  }
}
