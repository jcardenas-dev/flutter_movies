import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/popular_movies/domain/entities/popular_movie_params.dart';

abstract class GetPopularMoviesUseCase {
  Future<Either<Failure, List<Movie>>> call(PopularMovieParams params);
}