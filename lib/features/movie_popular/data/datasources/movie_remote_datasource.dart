import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/movie_popular/data/models/movie_response_model.dart';

abstract class MovieRemoteDataSource {
  Future<Either<Failure, MovieResponseModel>> getPopularMovies();
}