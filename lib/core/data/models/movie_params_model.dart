class MovieParamsModel {
  final bool includeAdult;
  final bool includeVideo;
  final String language;
  final int page;
  final String sortBy;
  final int? withReleaseType;
  final String? releaseDateGte;
  final String? releaseDateLte;

  MovieParamsModel({
    required this.includeAdult,
    required this.includeVideo,
    required this.language,
    required this.page,
    required this.sortBy,
    this.withReleaseType,
    this.releaseDateGte,
    this.releaseDateLte,
  });
  
  String buildQuery() {
    final queryParameters = <String, String>{
      'include_adult': includeAdult.toString(),
      'include_video': includeVideo.toString(),
      'language': language,
      'page': page.toString(),
      'sort_by': sortBy,
    };

    if (withReleaseType != null) {
      queryParameters['with_release_type'] = withReleaseType.toString();
    }

    if (releaseDateGte != null) {
      queryParameters['release_date.gte'] = releaseDateGte!;
    }

    if (releaseDateLte != null) {
      queryParameters['release_date.lte'] = releaseDateLte!;
    }

    final queryString = queryParameters.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    return queryString;
  }

}
