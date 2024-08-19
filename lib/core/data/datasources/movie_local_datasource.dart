import 'package:flutter_movies/core/data/models/movie_model.dart';

abstract class MovieLocalDatasource {
    Future<void> saveMovies(List<MovieModel> movies);
    Future<void> insertFavorite(int movieId);
    Future<void> deleteFavorite(int movieId);
    Future<List<int>> getFavoriteIds();
    Future<List<MovieModel>> getFavoriteMovies();
}