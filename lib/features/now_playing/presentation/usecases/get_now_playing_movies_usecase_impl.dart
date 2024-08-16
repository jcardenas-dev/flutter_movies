import 'package:either_dart/src/either.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/now_playing/domain/entities/playing_movies_params.dart';
import 'package:flutter_movies/features/now_playing/domain/usecases/get_now_playing_movies_usecase.dart';

class GetNowPlayingMoviesUsecaseImpl implements GetNowPlayingMoviesUsecase {

  final MovieRepository repository;

  GetNowPlayingMoviesUsecaseImpl({required this.repository});

  @override
  Future<Either<Failure, List<Movie>>> call(PlayingMoviesParams params) {
    final movieParams = MovieParams(
      sortBy: params.sortBy.value,
      language: params.language.value,
      page: params.page,
      withReleaseType: params.getReleaseTypes(),
      releaseDateGte: params.getReleaseDateGte(),
      releaseDateLte: params.getReleaseDateGte()
    );
    return repository.getMovies(movieParams);
  }

}