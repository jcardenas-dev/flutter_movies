import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/features/movie_detail/blocs/events/movie_detail_events.dart';
import 'package:flutter_movies/features/movie_detail/blocs/states/movie_detail_states.dart';
import 'package:flutter_movies/features/movie_detail/domain/usecases/get_movie_detail_usecase.dart';

class GetMovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUsecase getMovieDetailUsecase;

  GetMovieDetailBloc({required this.getMovieDetailUsecase}): super(MovieDetailInitial()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final result = await getMovieDetailUsecase(event.movieId);
      emit(MovieDetailLoaded(movie: result));
    });
  }
}