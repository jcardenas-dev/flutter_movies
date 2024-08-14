import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/data/models/movie_params_model.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/data/models/movie_response_model.dart';

abstract class MovieRemoteDataSource {
  Future<Either<Failure, MovieResponseModel>> getMovies(MovieParamsModel params);
}