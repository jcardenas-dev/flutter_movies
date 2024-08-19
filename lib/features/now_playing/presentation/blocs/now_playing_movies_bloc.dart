import 'package:flutter_movies/core/blocs/events/movie_event.dart';
import 'package:flutter_movies/core/blocs/states/movie_state.dart';
import 'package:flutter_movies/core/enums/movie_language.dart';
import 'package:flutter_movies/core/enums/movie_sort.dart';
import 'package:flutter_movies/core/presentation/blocs/base_movie_bloc.dart';
import 'package:flutter_movies/features/now_playing/domain/entities/playing_movies_params.dart';
import 'package:flutter_movies/features/now_playing/domain/usecases/get_now_playing_movies_usecase.dart';

class NowPlayingMoviesBloc extends BaseMovieBloc {
  final GetNowPlayingMoviesUsecase getNowPlayingMoviesUsecase;

  NowPlayingMoviesBloc({
    required this.getNowPlayingMoviesUsecase,
    required super.insertFavoriteMovieUsecase,
    required super.deleteFavoriteMovieUsecase
  }) {
    on<LoadMovies>((event, emit) async {
      emit(MovieLoading());
      final params = PlayingMoviesParams(
        sortBy: MovieSort.popularity,
        language: MovieLanguage.enUS,
        page: 1,
        releaseTypes: [
          ReleaseType.two,
          ReleaseType.three
        ],
        releaseDateGte: DateTime.now(),
        releaseDateLte: DateTime.now()
      );
      final result = await getNowPlayingMoviesUsecase(params);
      result.fold(
        (failure) => emit(MovieError(message: failure.message)),
        (movies) => emit(MovieLoaded(movies: movies)),
      );
    });

    on<ToggleFavorite>((event, emit) async {
      final state = this.state as MovieLoaded;
      final movieId = event.movieId;
      final updatedMovies = state.movies.map((movie) {
        if (movie.id == movieId) {
          if (movie.isFavorite) { deleteFavorite(movieId); }
          else { insertFavorite(movieId); }
          movie.toggleFavorite();
        }
        return movie;
      }).toList();
      emit(MovieLoaded(movies: updatedMovies));
    });
  }
}