import 'package:either_dart/either.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/now_playing/domain/entities/playing_movies_params.dart';

abstract class GetNowPlayingMoviesUsecase {
  Future<Either<Failure, List<Movie>>> call(PlayingMoviesParams params);
}