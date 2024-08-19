import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/domain/usecases/delete_favorite_movie_usecase.dart';

class DeleteFavoriteMovieUsecaseImpl implements DeleteFavoriteMovieUsecase {
  final MovieRepository repository;

  DeleteFavoriteMovieUsecaseImpl({required this.repository});
  
  @override
  Future<void> call(int movieId) {
    return repository.deleteFavorite(movieId);
  }
}