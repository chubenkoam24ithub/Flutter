import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<SearchMovie>(_onSearchMovie);
  }

  Future<void> _onSearchMovie(SearchMovie event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movie = await movieRepository.getMovie(event.query);
      emit(MovieLoaded(movie));
    } catch (e) {
      emit(MovieError("Ошибка поиска: ${e.toString().replaceAll("Exception: ", "")}"));
    }
  }
}