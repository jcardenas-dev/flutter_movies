import 'package:flutter_movies/core/blocs/events/movie_event.dart';

class DeleteFavoriteMovie extends MovieEvent {
  final int movieId;

  DeleteFavoriteMovie({required this.movieId});
  
}