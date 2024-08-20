import 'package:flutter_movies/core/data/database/daos/favorite_dao.dart';
import 'package:flutter_movies/core/data/database/daos/movie_dao.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource.dart';
import 'package:flutter_movies/core/data/models/movie_model.dart';

class MovieLocalDatasourceImpl implements MovieLocalDatasource {
  final MovieDao movieDao;
  final FavoriteDao favoriteDao;

  MovieLocalDatasourceImpl({
    required this.movieDao,
    required this.favoriteDao
  });

  @override
  Future<void> saveMovies(List<MovieModel> movies) {
    return movieDao.insertMovies(movies); 
  }

  @override
  Future<void> insertFavorite(int movieId) {
    return favoriteDao.insertFavorite(movieId);
  }

  @override
  Future<void> deleteFavorite(int movieId) {
    return favoriteDao.deleteFavorite(movieId);
  }

  @override
  Future<List<int>> getFavoriteIds() {
    return favoriteDao.getFavoriteIds();
  }

  @override
  Future<List<MovieModel>> getFavoriteMovies() async {
    final favoriteIds = await favoriteDao.getFavoriteIds();
    if (favoriteIds.isEmpty) return [];
    
    final favoriteMovies = await movieDao.getMoviesByIds(favoriteIds);
    return favoriteMovies;
  }

  @override
  Future<MovieModel> getMovieById(int id) {
    return movieDao.getMovieById(id);
  }

}