import 'package:flutter_movies/core/data/models/movie_response_model.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/features/home/domain/usecases/get_favorite_movies_usecase.dart';
import 'package:flutter_movies/features/home/presentation/usecases/get_favorite_movies_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helpers/json_reader.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetFavoriteMoviesUsecase getFavoriteMoviesUsecase;
  late MockMovieRepository mockMovieRepository;

  late List<Movie> movieList;
  late MovieParams movieParams;

  setUp((){
    mockMovieRepository = MockMovieRepository();
    getFavoriteMoviesUsecase = GetFavoriteMoviesUsecaseImpl(repository: mockMovieRepository);
  });

  setUpAll(() async {
    final jsonResponse = await readJson('movie_response_ok');
    final movieResponse = MovieResponseModel.fromJson(jsonResponse);
    movieList = movieResponse.toDomain([]);
    movieParams = MovieParams();

    registerFallbackValue(movieParams);
  });

  test('should return a list of favorite movies from the repository', () async {
    // Arrange
    when(() => mockMovieRepository.getFavorites(any()))
        .thenAnswer((_) async => movieList);

    // Act
    final result = await getFavoriteMoviesUsecase.call();

    // Assert
    expect(result, movieList);
    verify(() => mockMovieRepository.getFavorites(any())).called(1);
  });

}
