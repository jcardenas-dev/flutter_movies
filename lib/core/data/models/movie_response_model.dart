import 'package:flutter_movies/core/data/models/movie_model.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';

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

  List<Movie> toDomain(List<int> favoriteIds) {
    return results.map((toElement) => toElement.toDomain(favoriteIds.contains(toElement.id))).toList();
  }
}
