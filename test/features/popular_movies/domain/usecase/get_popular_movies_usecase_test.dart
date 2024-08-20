
import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/data/models/movie_response_model.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/core/enums/movie_language.dart';
import 'package:flutter_movies/core/enums/movie_sort.dart';
import 'package:flutter_movies/features/popular_movies/domain/entities/popular_movie_params.dart';
import 'package:flutter_movies/features/popular_movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:flutter_movies/features/popular_movies/presentation/usecases/get_popular_movies_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/json_reader.dart';

class MockMovieRepository extends Mock implements MovieRepository {}
class MockSettingRepository extends Mock implements SettingsRepository {}

void main() {
  late GetPopularMoviesUseCase getPopularMoviesUseCase;
  late MockMovieRepository mockMovieRepository;
  late MockSettingRepository mockSettingsRepository;

  late List<Movie> movieList;
  late PopularMovieParams popularMovieParams;

  setUpAll(() async {
    final jsonResponse = await readJson('movie_response_ok');
    final movieResponse = MovieResponseModel.fromJson(jsonResponse);
    movieList = movieResponse.toDomain([]);
    popularMovieParams = PopularMovieParams(
      sortBy: MovieSort.popularity, 
      language: MovieLanguage.enUS, 
      page: 1
    );

    registerFallbackValue(popularMovieParams);
    registerFallbackValue(MovieParams());
  });

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockSettingsRepository = MockSettingRepository();

    getPopularMoviesUseCase = GetPopularMoviesUseCaseImpl(
      repository: mockMovieRepository, settingsRepository: mockSettingsRepository
    );
  });

  test('should return a list of now playing movies from the repository', () async {
    // Arrange
    when(() => mockSettingsRepository.getLanguage())
        .thenAnswer((_) async => 'en');

    when(() => mockMovieRepository.getMovies(any()))
        .thenAnswer((_) async => Right(movieList));

    // Act
    final result = await getPopularMoviesUseCase.call(popularMovieParams);

    // Assert
    expect(result, Right(movieList));
    verify(() => mockSettingsRepository.getLanguage()).called(1);
    verify(() => mockMovieRepository.getMovies(any())).called(1);
  });

  test('should return a list of now playing movies in Spanish when language is set to Spanish', () async {
    // Arrange
    when(() => mockSettingsRepository.getLanguage())
        .thenAnswer((_) async => 'es');

    when(() => mockMovieRepository.getMovies(any()))
        .thenAnswer((_) async => Right(movieList));

    // Act
    final result = await getPopularMoviesUseCase.call(popularMovieParams);

    // Assert
    expect(result, Right(movieList));
    verify(() => mockSettingsRepository.getLanguage()).called(1);
    verify(() => mockMovieRepository.getMovies(any())).called(1);
  });
}