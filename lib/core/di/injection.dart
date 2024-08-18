import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movies/core/data/database/daos/favorite_dao.dart';
import 'package:flutter_movies/core/data/database/daos/movie_dao.dart';
import 'package:flutter_movies/core/data/database/database_helper.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource.dart';
import 'package:flutter_movies/core/data/datasources/movie_local_datasource_impl.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movies/core/data/datasources/movie_remote_datasource_impl.dart';
import 'package:flutter_movies/core/data/repositories/movie_repository_impl.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/network/api_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() async {
  // Get secrets
  String apiKey = String.fromEnvironment('API_KEY', defaultValue: (dotenv.env['API_KEY'] ?? ''));
  String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: dotenv.env['BASE_URL'] ?? '');
  
  // API Client
  sl.registerLazySingleton(() => ApiClient(baseUrl: baseUrl, apiKey: apiKey));

  // Database and Daos
  sl.registerLazySingleton(() => DatabaseHelper());
  sl.registerLazySingleton(() => MovieDao(databaseHelper: sl()));
  sl.registerLazySingleton(() => FavoriteDao(databaseHelper: sl()));

  // Data Source
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<MovieLocalDatasource>(
    () => MovieLocalDatasourceImpl(movieDao: sl(), favoriteDao: sl()),
  );  

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl(), localDatasource: sl()),
  );
}