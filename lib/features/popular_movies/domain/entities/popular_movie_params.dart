import 'package:flutter_movies/core/enums/movie_language.dart';
import 'package:flutter_movies/core/enums/movie_sort.dart';

class PopularMovieParams {
  final MovieSort sortBy;
  final MovieLanguage language;
  final int page;

  PopularMovieParams({
    required this.sortBy,
    required this.language,
    required this.page
  });
}