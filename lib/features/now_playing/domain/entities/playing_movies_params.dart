import 'package:flutter_movies/core/enums/movie_language.dart';
import 'package:flutter_movies/core/enums/movie_sort.dart';
import 'package:flutter_movies/core/utils/app_constants.dart';
import 'package:flutter_movies/main.dart';
import 'package:intl/intl.dart';

class PlayingMoviesParams {
  final MovieSort sortBy;
  final MovieLanguage language;
  final int page;
  final List<ReleaseType> releaseTypes;
  final DateTime releaseDateGte;
  final DateTime releaseDateLte;

  PlayingMoviesParams({
    required this.sortBy,
    required this.language,
    required this.page,
    required this.releaseTypes,
    required this.releaseDateGte,
    required this.releaseDateLte
  });

  String getReleaseTypes() {
      String result = releaseTypes.map((type) => type.value).join('|');
      logger.d('Result: $result');
      return result;
  }

  String getReleaseDateGte() {
      String formattedDate = DateFormat(AppConstants.FORMAT_DATE).format(releaseDateGte);
      return formattedDate;
  }

  String getReleaseDateLte() {
    String formattedDate = DateFormat(AppConstants.FORMAT_DATE).format(releaseDateLte);
    return formattedDate;
  }
}

enum ReleaseType{
  one(1),
  two(2),
  three(3),
  four(4),
  five(5),
  six(6);

  final int value;

  const ReleaseType(this.value);
}
