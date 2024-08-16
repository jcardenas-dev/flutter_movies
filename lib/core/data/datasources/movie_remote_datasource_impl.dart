import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/data/models/movie_params_model.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/network/api_client.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/core/data/models/movie_response_model.dart';
import 'package:flutter_movies/main.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;

  MovieRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<Failure, MovieResponseModel>> getMovies(MovieParamsModel params) async {
    try {
      final response = await apiClient.get('3/discover/movie', params.getParams());
      final data = json.decode(response.body);
      final movieResponse = MovieResponseModel.fromJson(data);
      return Right(movieResponse);
    } on MovieFailure catch (e) {
      logger.e(e);
      return Left(e);
    } catch (e) {
      logger.e(e);
      return Left(UnknownErrorFailure(message: e.toString()));
    }
  }

}