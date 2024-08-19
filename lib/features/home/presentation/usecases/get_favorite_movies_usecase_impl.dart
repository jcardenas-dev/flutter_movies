import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/features/home/domain/usecases/get_favorite_movies_usecase.dart';

class GetFavoriteMoviesUsecaseImpl implements GetFavoriteMoviesUsecase {
  final MovieRepository repository;

  GetFavoriteMoviesUsecaseImpl({required this.repository});

  @override
  Future<List<Movie>> call() {
    final params = MovieParams();
    return repository.getFavorites(params);
  }

}