import 'package:flutter_movies/core/di/injection.dart';
import 'package:flutter_movies/features/movie_detail/blocs/get_movie_detail_bloc.dart';
import 'package:flutter_movies/features/movie_detail/domain/usecases/get_movie_detail_usecase.dart';
import 'package:flutter_movies/features/movie_detail/presentation/usecases/get_movie_detail_usecase_impl.dart';

void setupMovieDetailInjection() {
  // Registrar Use Case
  sl.registerLazySingleton<GetMovieDetailUsecase>(
    () => GetMovieDetailUsecaseImpl(repository: sl()),
  );

  sl.registerFactory(() => GetMovieDetailBloc(
    getMovieDetailUsecase: sl(),
  ));
}