
import 'package:flutter_movies/core/data/database/daos/favorite_dao.dart';
import 'package:flutter_movies/core/data/database/daos/movie_dao.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource_impl.dart';
import 'package:flutter_movies/core/data/models/movie_model.dart';
import 'package:flutter_movies/core/data/models/movie_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/json_reader.dart';

class MockMovieDao extends Mock implements MovieDao {}
class MockFavoriteDao extends Mock implements FavoriteDao {}

void main() {
  late MovieLocalDatasource dataSource;
  late MockMovieDao mockMovieDao;
  late MockFavoriteDao mockFavoriteDao;

  late List<MovieModel> movieList;

  setUp(() {
    mockMovieDao = MockMovieDao();
    mockFavoriteDao = MockFavoriteDao();
    dataSource = MovieLocalDatasourceImpl(
      movieDao: mockMovieDao, 
      favoriteDao: mockFavoriteDao
    );
  });

  setUpAll(() async {
    final jsonResponse = await readJson('movie_response_ok');
    final movieResponse = MovieResponseModel.fromJson(jsonResponse);
    movieList = movieResponse.results;
  });

  group('saveMovies', () {
    test('should call insertMovies on movieDao with correct movies', () async {
      // Arrange
      final movies = movieList;
      when(() => dataSource.saveMovies(any()))
        .thenAnswer((_) async => {});
      
      // Act
      await dataSource.saveMovies(movies);
      
      // Assert
      verify(() => mockMovieDao.insertMovies(any())).called(1);
    });
  });

  group('insertFavorite', () {
    test('should call insertFavorite on favoriteDao with correct movieId', () async {
      // Arrange
      const movieId = 1;
      when(() => mockFavoriteDao.insertFavorite(any()))
        .thenAnswer((_) async => {});
      
      // Act
      await dataSource.insertFavorite(movieId);
      
      // Assert
      verify(() => mockFavoriteDao.insertFavorite(any())).called(1);
    });
  });

  group('deleteFavorite', () {
    test('should call deleteFavorite on favoriteDao with correct movieId', () async {
      // Arrange
      const tMovieId = 1;
      when(() => mockFavoriteDao.deleteFavorite(any()))
        .thenAnswer((_) async => {});
      
      // Act
      await dataSource.deleteFavorite(tMovieId);
      
      // Assert
      verify(() => mockFavoriteDao.deleteFavorite(any())).called(1);
    });
  });

  group('getFavoriteIds', () {
    test('should call getFavoriteIds on favoriteDao and return result', () async {
      // Arrange
      final favoriteIds = [1, 2, 3];
      when(() => mockFavoriteDao.getFavoriteIds()).thenAnswer((_) async => favoriteIds);
      
      // Act
      final result = await dataSource.getFavoriteIds();
      
      // Assert
      expect(result, favoriteIds);
      verify(() => mockFavoriteDao.getFavoriteIds()).called(1);
    });
  });

  group('getFavoriteMovies', () {
    test('should return an empty list if no favoriteIds are found', () async {
      // Arrange
      when(() => mockFavoriteDao.getFavoriteIds()).thenAnswer((_) async => []);
      
      // Act
      final result = await dataSource.getFavoriteMovies();
      
      // Assert
      expect(result, []);
    });

    test('should return list of movies if favoriteIds are found', () async {
      // Arrange
      final favoriteIds = [1, 2];
      final movies = movieList;

      when(() => mockFavoriteDao.getFavoriteIds()).thenAnswer((_) async => favoriteIds);
      when(() => mockMovieDao.getMoviesByIds(favoriteIds)).thenAnswer((_) async => movies);
      
      // Act
      final result = await dataSource.getFavoriteMovies();
      
      // Assert
      expect(result, movies);
      verify(() => mockFavoriteDao.getFavoriteIds()).called(1);
      verify(() => mockMovieDao.getMoviesByIds(favoriteIds)).called(1);
    });
  });
}