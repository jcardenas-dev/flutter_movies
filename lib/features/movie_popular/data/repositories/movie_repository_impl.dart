import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/movie_popular/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/features/movie_popular/domain/entities/movie.dart';
import 'package:flutter_movies/features/movie_popular/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final remoteMovies = await remoteDataSource.getPopularMovies();
      return remoteMovies.fold(
        (failure) => Left(failure), 
        (movieReponse) => Right(movieReponse.toDomain()));
    } catch (e) {
      return Left(UnknownErrorFailure(message: e.toString()));
    }
  }
}