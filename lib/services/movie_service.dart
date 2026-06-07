import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  static const String apiKey = "9dbdc806"; 
  static const String baseUrl = "http://www.omdbapi.com/";

  Future<Movie?> searchMovie(String title) async {
    final url = Uri.parse("$baseUrl?apikey=$apiKey&t=$title&lang=ru");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
           return Movie.fromJson(data);
        }
        return null; // Фильм не найден
      } else {
        return null;
      }
    } catch (e) {
      print("Ошибка получения данных: $e");
      return null;
    }
  }
}