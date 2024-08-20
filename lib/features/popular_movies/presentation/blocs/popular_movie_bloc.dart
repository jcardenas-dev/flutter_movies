import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/core/blocs/events/movie_event.dart';
import 'package:flutter_movies/core/blocs/states/movie_state.dart';
import 'package:flutter_movies/core/enums/movie_language.dart';
import 'package:flutter_movies/core/enums/movie_sort.dart';
import 'package:flutter_movies/core/presentation/blocs/base_movie_bloc.dart';
import 'package:flutter_movies/features/popular_movies/domain/entities/popular_movie_params.dart';
import 'package:flutter_movies/features/popular_movies/domain/usecases/get_popular_movies_usecase.dart';

class PopularMovieBloc extends BaseMovieBloc {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  PopularMovieBloc({
    required this.getPopularMoviesUseCase, 
    required super.insertFavoriteMovieUsecase, 
    required super.deleteFavoriteMovieUsecase
  }) {
    on<LoadMovies>((event, emit) async {
      emit(MovieLoading());
      final params = PopularMovieParams(
        sortBy: MovieSort.popularity,
        language: MovieLanguage.enUS,
        page: 1
      );
      final result = await getPopularMoviesUseCase(params);
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
