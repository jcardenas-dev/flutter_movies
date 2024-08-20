import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/domain/usecases/insert_favorite_movie_usecase.dart';

class InsertFavoriteMovieUsecaseImpl implements InsertFavoriteMovieUsecase {
  final MovieRepository repository;

  InsertFavoriteMovieUsecaseImpl({required this.repository});
  
  @override
  Future<void> call(int movieId) {
    return repository.insertFavorite(movieId);
  }
}