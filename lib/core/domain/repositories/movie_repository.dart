import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/data/models/movie_params_model.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMovies(MovieParamsModel params);
}