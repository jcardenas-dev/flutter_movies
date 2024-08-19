import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource.dart';
import 'package:flutter_movies/core/data/models/movie_params_model.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDatasource localDatasource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDatasource
  });

  @override
  Future<Either<Failure, List<Movie>>> getMovies(MovieParams params) async {
    try {
      final queryParams = MovieParamsModel(
        includeAdult: params.includeAdult, 
        includeVideo: params.includeVideo, 
        language: params.language, 
        page: params.page, 
        sortBy: params.sortBy,
        withReleaseType: params.withReleaseType,
        releaseDateGte: params.releaseDateGte,
        releaseDateLte: params.releaseDateLte
      );
      final remoteMovies = await remoteDataSource.getMovies(queryParams);
      return remoteMovies.fold(
        (failure) => Left(failure), 
        (movieReponse) async {
          await localDatasource.saveMovies(movieReponse.results);
          final favoriteList = await localDatasource.getFavoriteIds();
          final mapped = movieReponse.toDomain(favoriteList);
          return Right(mapped);
        }
      );
    } on MovieFailure catch(e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownErrorFailure(message: e.toString()));
    }
  }

  @override
  Future<List<Movie>> getFavorites(MovieParams params) async {
    final favoriteMovies = await localDatasource.getFavoriteMovies();
    return favoriteMovies.map((toElement) =>
      toElement.toDomain(true)
    ).toList();
  }

  @override
  Future<void> insertFavorite(int movieId) async {
    await localDatasource.insertFavorite(movieId);
  }

  @override
  Future<void> deleteFavorite(int movieId) async {
    await localDatasource.deleteFavorite(movieId);
  }

  @override
  Future<Movie> getMovieById(int movieId) async {
    final result = await localDatasource.getMovieById(movieId);
    return result.toDomain(false);
  }
}