import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/network/api_client.dart';
import 'package:flutter_movies/features/movie_popular/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/features/movie_popular/data/models/movie_response_model.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;

  MovieRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<Failure, MovieResponseModel>> getPopularMovies() async {
    try {
      final response = await apiClient.get('/account/21444303/favorite/movies');
      final data = json.decode(response.body);
      final movieResponse = MovieResponseModel.fromJson(data);
      return Right(movieResponse);
    } on MovieFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownErrorFailure(message: e.toString()));
    }
  }

}