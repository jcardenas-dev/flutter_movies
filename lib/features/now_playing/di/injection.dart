import 'package:flutter_movies/core/di/injection.dart';
import 'package:flutter_movies/features/now_playing/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:flutter_movies/features/now_playing/presentation/blocs/now_playing_movies_bloc.dart';
import 'package:flutter_movies/features/now_playing/presentation/usecases/get_now_playing_movies_usecase_impl.dart';

void setupNowPopularMoviesInjection() {
  // Registrar Use Case
  sl.registerLazySingleton<GetNowPlayingMoviesUsecase>(
    () => GetNowPlayingMoviesUsecaseImpl(repository: sl(), settingsRepository: sl()),
  );

  sl.registerFactory(() => NowPlayingMoviesBloc(
    getNowPlayingMoviesUsecase: sl(),
    insertFavoriteMovieUsecase: sl(),
    deleteFavoriteMovieUsecase: sl()
  ));
}