import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/data/models/movie_params_model.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getMovies(MovieParamsModel params) async {
    try {
      final remoteMovies = await remoteDataSource.getMovies(params);
      return remoteMovies.fold(
        (failure) => Left(failure), 
        (movieReponse) => Right(movieReponse.toDomain()));
    } catch (e) {
      return Left(UnknownErrorFailure(message: e.toString()));
    }
  }
}