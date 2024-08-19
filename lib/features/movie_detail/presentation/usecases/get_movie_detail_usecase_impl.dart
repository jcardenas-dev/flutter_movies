import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/features/movie_detail/domain/usecases/get_movie_detail_usecase.dart';

class GetMovieDetailUsecaseImpl implements GetMovieDetailUsecase {
  final MovieRepository repository;

  GetMovieDetailUsecaseImpl({required this.repository});

  @override
  Future<Movie> call(int movieId) {
    return repository.getMovieById(movieId);
  }

}