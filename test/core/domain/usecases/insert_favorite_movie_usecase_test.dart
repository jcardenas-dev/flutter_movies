import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/domain/usecases/insert_favorite_movie_usecase.dart';
import 'package:flutter_movies/core/presentation/usecases/insert_favorite_movie_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late InsertFavoriteMovieUsecase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = InsertFavoriteMovieUsecaseImpl(repository: mockMovieRepository);
  });

  test('should call insertFavorite on the repository with the correct movieId', () async {
    // Arrange
    const tMovieId = 1;
    when(() => mockMovieRepository.insertFavorite(any()))
      .thenAnswer((_) async => {});

    // Act
    await usecase.call(tMovieId);

    // Assert
    verify(() => mockMovieRepository.insertFavorite(any())).called(1);
  });

}