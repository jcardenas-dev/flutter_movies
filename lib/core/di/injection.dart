import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movies/core/data/database/daos/favorite_dao.dart';
import 'package:flutter_movies/core/data/database/daos/movie_dao.dart';
import 'package:flutter_movies/core/data/database/database_helper.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource_impl.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource_impl.dart';
import 'package:flutter_movies/core/data/datasources/settings_local_datasource.dart';
import 'package:flutter_movies/core/data/datasources/settings_local_datasource_impl.dart';
import 'package:flutter_movies/core/data/repositories/movie_repository_impl.dart';
import 'package:flutter_movies/core/data/repositories/settings_repository_impl.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/core/domain/usecases/delete_favorite_movie_usecase.dart';
import 'package:flutter_movies/core/domain/usecases/insert_favorite_movie_usecase.dart';
import 'package:flutter_movies/core/network/api_client.dart';
import 'package:flutter_movies/core/presentation/usecases/delete_favorite_movie_usecase_impl.dart';
import 'package:flutter_movies/core/presentation/usecases/insert_favorite_movie_usecase_impl.dart';
import 'package:flutter_movies/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/notifier/language_notifier.dart';
import 'package:flutter_movies/features/settings/presentation/blocs/notifier/theme_notifier.dart';
import 'package:flutter_movies/features/settings/domain/usecases/is_dark_usecase.dart';
import 'package:flutter_movies/features/settings/presentation/usecases/get_language_usecase_impl.dart';
import 'package:flutter_movies/features/settings/presentation/usecases/is_dark_usecase_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void setup() async {
  // Get secrets
  String apiKey = String.fromEnvironment('API_KEY', defaultValue: (dotenv.env['API_KEY'] ?? ''));
  String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: dotenv.env['BASE_URL'] ?? '');
  
  // API Client
  sl.registerSingleton<http.Client>(http.Client());
  sl.registerLazySingleton(() => ApiClient(client: sl(), baseUrl: baseUrl, apiKey: apiKey));

  // Database and Daos
  sl.registerLazySingleton(() => DatabaseHelper());
  sl.registerLazySingleton(() => MovieDao(databaseHelper: sl()));
  sl.registerLazySingleton(() => FavoriteDao(databaseHelper: sl()));

  // SharedPreference
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Data Source
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<MovieLocalDatasource>(
    () => MovieLocalDatasourceImpl(movieDao: sl(), favoriteDao: sl()),
  );

  sl.registerLazySingleton<SettingsLocalDatasource>(
    () => SettingsLocalDatasourceImpl(prefs: sl()),
  );

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl(), localDatasource: sl()),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(settingsLocalDatasource: sl()),
  );

  // Usecases
  sl.registerLazySingleton<InsertFavoriteMovieUsecase>(
    () => InsertFavoriteMovieUsecaseImpl(repository: sl()),
  );

  sl.registerLazySingleton<DeleteFavoriteMovieUsecase>(
    () => DeleteFavoriteMovieUsecaseImpl(repository: sl()),
  );

  sl.registerLazySingleton<IsDarkUsecase>(
    () => IsDarkUsecaseImpl(repository: sl()),
  );

  sl.registerLazySingleton<GetLanguageUsecase>(
    () => GetLanguageUsecaseImpl(repository: sl()),
  );

  // Notifiers
  sl.registerLazySingleton(() => ThemeNotifier(isDarkUsecase: sl()));
  sl.registerLazySingleton(() => LanguageNotifier(getLanguageUsecase: sl()));
}