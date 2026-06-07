import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movie/movie_bloc.dart';
import '../blocs/movie/movie_event.dart';
import '../blocs/movie/movie_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _searchMovie() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<MovieBloc>().add(SearchMovie(query));
      FocusScope.of(context).unfocus(); // Скрываем клавиатуру после поиска
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Убрали backgroundColor: Colors.white, теперь фон подстраивается под тему автоматически
      appBar: AppBar(
        title: const Text("Поиск фильмов"),
        // Убрали backgroundColor: Colors.blue, чтобы AppBar следовал теме
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Поле поиска
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Название фильма (на англ.)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.movie_creation),
                    ),
                    onSubmitted: (_) => _searchMovie(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _searchMovie,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Вывод результата (BLoC)
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieInitial) {
                    return const Center(
                      child: Text("Введите название фильма, чтобы начать поиск", 
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    );
                  } else if (state is MovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoaded) {
                    final movie = state.movie;
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Постер фильма
                          if (movie.posterUrl != 'N/A' && movie.posterUrl.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(movie.posterUrl, height: 350, fit: BoxFit.cover),
                            )
                          else
                            const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                            
                          const SizedBox(height: 20),
                          Text(movie.title,
                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 10),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                              const SizedBox(width: 5),
                              Text(movie.year, style: const TextStyle(fontSize: 18, color: Colors.grey)),
                              const SizedBox(width: 20),
                              const Icon(Icons.star, size: 18, color: Colors.orange),
                              const SizedBox(width: 5),
                              Text(movie.imdbRating, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Описание фильма
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              // Используем основной цвет текущей темы с прозрачностью вместо жесткого Colors.blue
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(movie.plot,
                                style: const TextStyle(fontSize: 16, height: 1.5),
                                textAlign: TextAlign.justify),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MovieError) {
                    return Center(
                      child: Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 16)),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}