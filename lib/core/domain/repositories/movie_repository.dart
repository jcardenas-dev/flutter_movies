import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMovies(MovieParams params);
  Future<List<Movie>> getFavorites(MovieParams params);
  Future<void> insertFavorite(int movieId);
  Future<void> deleteFavorite(int movieId);
  Future<Movie> getMovieById(int movieId);
}