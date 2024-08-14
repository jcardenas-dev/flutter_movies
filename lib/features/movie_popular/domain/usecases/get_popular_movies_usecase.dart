import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/movie_popular/domain/entities/popular_movie_params.dart';

abstract class GetPopularMoviesUsecase {
  Future<Either<Failure, List<Movie>>> getMovies(PopularMovieParams params);
}