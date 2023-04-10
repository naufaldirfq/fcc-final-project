part of 'search_movie_bloc.dart';

@immutable
abstract class SearchMovieState {}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoaded extends SearchMovieState {
  final List<Movie> movies;

  SearchMovieLoaded(this.movies);
}

class SearchMovieError extends SearchMovieState {
  final String message;

  SearchMovieError(this.message);
}