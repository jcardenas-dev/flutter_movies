import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/movie_popular/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies();
}