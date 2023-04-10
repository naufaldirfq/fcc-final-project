part of 'recommended_movie_bloc.dart';

@immutable
abstract class RecommendedMovieState {}

class RecommendedMovieInitial extends RecommendedMovieState {}

class RecommendedMovieLoaded extends RecommendedMovieState {
  final List<Movie> movies;

  RecommendedMovieLoaded(this.movies);
}

class RecommendedMovieError extends RecommendedMovieState {
  final String message;

  RecommendedMovieError(this.message);
}