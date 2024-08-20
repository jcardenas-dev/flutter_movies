import 'package:either_dart/src/either.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/core/domain/entities/movie_params.dart';
import 'package:flutter_movies/core/domain/repositories/movie_repository.dart';
import 'package:flutter_movies/core/domain/repositories/settings_repository.dart';
import 'package:flutter_movies/core/enums/movie_language.dart';
import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/features/popular_movies/domain/entities/popular_movie_params.dart';
import 'package:flutter_movies/features/popular_movies/domain/usecases/get_popular_movies_usecase.dart';

class GetPopularMoviesUseCaseImpl implements GetPopularMoviesUseCase {
  final MovieRepository repository;
  final SettingsRepository settingsRepository;

  GetPopularMoviesUseCaseImpl({
    required this.repository,
    required this.settingsRepository
  });

  @override
  Future<Either<Failure, List<Movie>>> call(PopularMovieParams params) async {
    var language = MovieLanguage.enUS.value;
    var langCode = await settingsRepository.getLanguage();
    if(langCode == 'es') {
      language = MovieLanguage.esMX.value;
    }
    final movieParams = MovieParams(
      sortBy: params.sortBy.value,
      language: language,
      page: params.page
    );
    return repository.getMovies(movieParams);
  }

}