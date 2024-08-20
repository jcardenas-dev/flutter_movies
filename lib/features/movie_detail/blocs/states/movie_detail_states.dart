import 'package:equatable/equatable.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';

abstract class MovieDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Movie movie;

  MovieDetailLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}