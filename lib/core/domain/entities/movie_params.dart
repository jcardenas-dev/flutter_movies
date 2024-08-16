class MovieParams {
  final bool includeAdult;
  final bool includeVideo;
  final String language;
  final int page;
  final String sortBy;
  final String? withReleaseType;
  final String? releaseDateGte;
  final String? releaseDateLte;

  MovieParams({
    this.includeAdult = false,
    this.includeVideo = false,
    this.language = 'en-US',
    this.page = 1,
    this.sortBy = 'popularity.desc',
    this.withReleaseType,
    this.releaseDateGte,
    this.releaseDateLte,
  });
}
