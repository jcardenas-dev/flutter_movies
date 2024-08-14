import 'package:either_dart/src/either.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/movie_popular/domain/entities/popular_movie_params.dart';
import 'package:flutter_movies/features/movie_popular/domain/usecases/get_popular_movies_usecase.dart';

class GetPopularMoviesUsecaseImpl implements GetPopularMoviesUsecase {
  final MovieRepository repository;

  GetPopularMoviesUsecaseImpl({
    required this.repository
  });

  @override
  Future<Either<Failure, List<Movie>>> getMovies(PopularMovieParams params) {
    final movieParams = MovieParams(
      sortBy: params.sortBy.value,
      language: params.language.value,
      page: params.page
    );
    return repository.getMovies(movieParams);
  }

}