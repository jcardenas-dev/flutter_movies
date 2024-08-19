
import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource_impl.dart';
import 'package:flutter_movies/core/data/models/movie_params_model.dart';
import 'package:flutter_movies/core/data/models/movie_response_model.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/network/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/json_reader.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MovieRemoteDataSource dataSource;
  late MockApiClient mockApiClient;

  late Map<String, dynamic> jsonResponse;
  late MovieResponseModel movieResponse;
  late Uri uri;
  late MovieParamsModel movieParams;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = MovieRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  setUpAll(() async {
    jsonResponse = await readJson('movie_response_ok');
    movieResponse = MovieResponseModel.fromJson(jsonResponse);
    uri = Uri.parse('3/discover/movie');
    movieParams = MovieParamsModel(
      includeAdult: false, 
      includeVideo: false, 
      language: 'en', 
      page: 1, 
      sortBy: '',
    );
    registerFallbackValue(jsonResponse);
    registerFallbackValue(movieResponse);
    registerFallbackValue(uri);
    registerFallbackValue(movieParams);
  });

  test('should return MovieResponseModel when the call to ApiClient is successful', () async {
    // Arrange
    when(() => mockApiClient.get(any(), any()))
        .thenAnswer((_) async => Response(json.encode(jsonResponse), 200));

    // Act
    final result = await dataSource.getMovies(movieParams);

    // Assert
    expect(result, isA<Either<Failure, MovieResponseModel>>());
    verify(() => mockApiClient.get(any(), any())).called(1);
  });

  test('should return MovieFailure when ApiClient throws a MovieFailure', () async {
    // Arrange
    const failure = MovieFailure(message: '');
    when(() => mockApiClient.get(any(), any())).thenThrow(failure);

    // Act
    final result = await dataSource.getMovies(movieParams);

    // Assert
    expect(result, const Left(failure));
    verify(() => mockApiClient.get(any(), any())).called(1);
  });

  test('should return UnknownErrorFailure when ApiClient throws an unknown error', () async {
    // Arrange
    final exception = Exception('Unexpected error');
    when(() => mockApiClient.get(any(), any())).thenThrow(exception);

    // Act
    final result = await dataSource.getMovies(movieParams);

    // Assert
    expect(result, Left(UnknownErrorFailure(message: exception.toString())));
    verify(() => mockApiClient.get(any(), any())).called(1);
  });
}