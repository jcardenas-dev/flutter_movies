import 'package:flutter_movies/core/domain/entities/movie.dart';

abstract class GetMovieDetailUsecase {
  Future<Movie> call(int movieId);
}