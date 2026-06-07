import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieRepository {
  final MovieService movieService;

  MovieRepository({required this.movieService});

  Future<Movie> getMovie(String title) async {
    final movie = await movieService.searchMovie(title);

    if (movie == null) {
      throw Exception("Фильм не найден. Проверьте название.");
    }

    return movie;
  }
}