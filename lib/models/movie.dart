class Movie {
  final String title;
  final String year;
  final String plot;
  final String posterUrl;
  final String imdbRating;

  Movie({
    required this.title,
    required this.year,
    required this.plot,
    required this.posterUrl,
    required this.imdbRating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'Неизвестно',
      year: json['Year'] ?? '',
      plot: json['Plot'] ?? 'Описание отсутствует',
      posterUrl: json['Poster'] ?? '',
      imdbRating: json['imdbRating'] ?? 'N/A',
    );
  }
}