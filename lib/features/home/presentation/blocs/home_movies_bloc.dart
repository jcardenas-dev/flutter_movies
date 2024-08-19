import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/core/blocs/events/movie_event.dart';
import 'package:flutter_movies/core/blocs/states/movie_state.dart';
import 'package:flutter_movies/core/domain/usecases/delete_favorite_movie_usecase.dart';
import 'package:flutter_movies/features/home/domain/usecases/get_favorite_movies_usecase.dart';
import 'package:flutter_movies/features/home/presentation/blocs/events/favorite_events.dart';
import 'package:flutter_movies/features/home/presentation/blocs/states/favorite_states.dart';

class HomeMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetFavoriteMoviesUsecase getFavoriteMoviesUsecase;
  final DeleteFavoriteMovieUsecase deleteFavoriteMovieUsecase;

  HomeMoviesBloc({
    required this.getFavoriteMoviesUsecase,
    required this.deleteFavoriteMovieUsecase
  }) : super(MovieInitial()) {
    on<LoadMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await getFavoriteMoviesUsecase();
      if (result.isEmpty) {
        emit(EmptyState());
      }
      else {
        emit(MovieLoaded(movies: result));
      }
    });

    on<DeleteFavoriteMovie>((event, emit) async {
      await deleteFavoriteMovieUsecase(event.movieId);
      final state = this.state as MovieLoaded;
      final movieId = event.movieId;
      final updatedMovies = state.movies.where((movie) => movie.id != movieId).toList();
      if (updatedMovies.isEmpty) {
        emit(EmptyState());
      } else {
        emit(MovieLoaded(movies: updatedMovies));
      }
    });
  }
}