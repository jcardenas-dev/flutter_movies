import 'package:flutter_movies/core/di/injection.dart';
import 'package:flutter_movies/features/home/domain/usecases/get_favorite_movies_usecase.dart';
import 'package:flutter_movies/features/home/presentation/blocs/home_movies_bloc.dart';
import 'package:flutter_movies/features/home/presentation/usecases/get_favorite_movies_usecase_impl.dart';

void setupHomeMoviesInjection() {
  // Registrar Use Case
  sl.registerLazySingleton<GetFavoriteMoviesUsecase>(
    () => GetFavoriteMoviesUsecaseImpl(repository: sl()),
  );

  sl.registerFactory(() => HomeMoviesBloc(
    getFavoriteMoviesUsecase: sl(),
    deleteFavoriteMovieUsecase: sl()
  ));
}