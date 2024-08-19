import 'package:flutter_movies/core/domain/entities/movie.dart';

abstract class GetFavoriteMoviesUsecase {
  Future<List<Movie>> call();
}