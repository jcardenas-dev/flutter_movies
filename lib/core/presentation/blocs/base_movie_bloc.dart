import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/core/blocs/events/movie_event.dart';
import 'package:flutter_movies/core/blocs/states/movie_state.dart';
import 'package:flutter_movies/core/domain/usecases/delete_favorite_movie_usecase.dart';
import 'package:flutter_movies/core/domain/usecases/insert_favorite_movie_usecase.dart';

class BaseMovieBloc extends Bloc<MovieEvent, MovieState> {
  final InsertFavoriteMovieUsecase insertFavoriteMovieUsecase;
  final DeleteFavoriteMovieUsecase deleteFavoriteMovieUsecase;

  BaseMovieBloc({
    required this.insertFavoriteMovieUsecase,
    required this.deleteFavoriteMovieUsecase
  }): super(MovieInitial());

  Future<void> deleteFavorite(int movieId) async {
    deleteFavoriteMovieUsecase.call(movieId);
  }

  Future<void> insertFavorite(int movieId) async {
    insertFavoriteMovieUsecase.call(movieId);
  }
}