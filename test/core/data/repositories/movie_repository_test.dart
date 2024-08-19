import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/core/data/models/movie_model.dart';
import 'package:flutter_movies/core/data/models/movie_params_model.dart';
import 'package:flutter_movies/core/data/models/movie_response_model.dart';
import 'package:flutter_movies/core/data/repositories/movie_repository_impl.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}
class MockMovieLocalDatasource extends Mock implements MovieLocalDatasource {}

void main() {
  late MovieRepository movieRepository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late MockMovieLocalDatasource mockMovieLocalDatasource;

  setUpAll(() {
    // Registrar un fallback value para MovieParamsModel
    registerFallbackValue(MovieParamsModel(
      includeAdult: false, 
      includeVideo: false, 
      language: 'en', 
      page: 1, 
      sortBy: '',
    ));
  });

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    mockMovieLocalDatasource = MockMovieLocalDatasource();
    movieRepository = MovieRepositoryImpl(
      remoteDataSource: mockMovieRemoteDataSource, 
      localDatasource: mockMovieLocalDatasource
    );
  });

  group('getMovies', () {
    final movieResponse = MovieResponseModel(
      page: 1, 
      results: [
        MovieModel (
          adult: false, 
          backdropPath: '', 
          genreIds: [1,2], 
          id: 1, 
          originalLanguage: '', 
          originalTitle: '', 
          overview: '', 
          popularity: 7.7, 
          posterPath: '', 
          releaseDate: '2024-08-19', 
          title: '', 
          video: false, 
          voteAverage: 7.7, 
          voteCount: 1000)
      ], 
      totalPages: 10, 
      totalResults: 1
    );

    test('should return a list of movies on success', () async {
      // Arrange
      when(() => mockMovieRemoteDataSource.getMovies(any()))
        .thenAnswer((_) async => Right(movieResponse));

      when(() => mockMovieLocalDatasource.saveMovies(any()))
        .thenAnswer((_) async {});

      when(() => mockMovieLocalDatasource.getFavoriteIds())
        .thenAnswer((_) async => <int>[]);

      // Act
      final result = await movieRepository.getMovies(MovieParams());

      // Assert
      expect(result, isA<Either<Failure, List<Movie>>>());
      verify(() => mockMovieRemoteDataSource.getMovies(any())).called(1);
      verify(() => mockMovieLocalDatasource.saveMovies(any())).called(1);
      verify(() => mockMovieLocalDatasource.getFavoriteIds()).called(1);
    });

    test('should return a failure when remoteDataSource fails', () async {
      // Arrange
      const failure = MovieFailure(message: '');
      when(() => mockMovieRemoteDataSource.getMovies(any()))
        .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await movieRepository.getMovies(MovieParams());

      // Assert
      expect(result, const Left(failure));
      verify(() => mockMovieRemoteDataSource.getMovies(any())).called(1);
      verifyNever(() => mockMovieLocalDatasource.saveMovies(any()));
    });
  });

  group('getFavorites', () {
    final favoriteMovies = [
      MovieModel (
          adult: false, 
          backdropPath: '', 
          genreIds: [1,2], 
          id: 1, 
          originalLanguage: '', 
          originalTitle: '', 
          overview: '', 
          popularity: 7.7, 
          posterPath: '', 
          releaseDate: '2024-08-19', 
          title: '', 
          video: false, 
          voteAverage: 7.7, 
          voteCount: 1000
        )
    ];

    test('should return a list of favorite movies', () async {
      // Arrange
      when(() => mockMovieLocalDatasource.getFavoriteMovies())
          .thenAnswer((_) async => favoriteMovies);

      // Act
      final result = await movieRepository.getFavorites(MovieParams());

      // Assert
      expect(result, isA<List<Movie>>());
      verify(() => mockMovieLocalDatasource.getFavoriteMovies()).called(1);
    });
  });

  group('insertFavorite', () {
    test('should call insertFavorite on localDatasource', () async {
      // Arrange
      const movieId = 1;
      when(() => mockMovieLocalDatasource.insertFavorite(any()))
          .thenAnswer((_) async => {});

      // Act
      await movieRepository.insertFavorite(movieId);

      // Assert
      verify(() => mockMovieLocalDatasource.insertFavorite(any())).called(1);
    });
  });

  group('deleteFavorite', () {
    test('should call deleteFavorite on localDatasource', () async {
      // Arrange
      const movieId = 1;
      when(() => mockMovieLocalDatasource.deleteFavorite(any()))
          .thenAnswer((_) async => {});

      // Act
      await movieRepository.deleteFavorite(movieId);

      // Assert
      verify(() => mockMovieLocalDatasource.deleteFavorite(any())).called(1);
    });
  });
}