import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class SearchMovie extends MovieEvent {
  final String query;

  const SearchMovie(this.query);

  @override
  List<Object?> get props => [query];
}