import 'package:flutter_movies/core/di/injection.dart';
import 'package:flutter_movies/features/popular_movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:flutter_movies/features/popular_movies/presentation/blocs/popular_movie_bloc.dart';
import 'package:flutter_movies/features/popular_movies/presentation/usecases/get_popular_movies_usecase_impl.dart';

void setupPopularMoviesInjection() {
  // Registrar Use Case
  sl.registerLazySingleton<GetPopularMoviesUseCase>(
    () => GetPopularMoviesUseCaseImpl(repository: sl()),
  );

  sl.registerFactory(() => PopularMovieBloc(
    getPopularMoviesUseCase: sl(),
    insertFavoriteMovieUsecase: sl(),
    deleteFavoriteMovieUsecase: sl()
  ));
}