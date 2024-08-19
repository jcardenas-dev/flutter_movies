import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMovies extends MovieEvent {}

class ToggleFavorite extends MovieEvent {

  final int movieId;
  ToggleFavorite({required this.movieId});
}
