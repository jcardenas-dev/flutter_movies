enum MovieSort {
  popularity('popularity.desc'),
  releaseDate('release_date.desc'),
  title('title.asc');

  final String value;

  const MovieSort(this.value);
}
