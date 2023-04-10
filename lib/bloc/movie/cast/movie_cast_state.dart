part of 'movie_cast_bloc.dart';

@immutable
abstract class MovieCastState {}

class MovieCastInitial extends MovieCastState {}

class MovieCastLoaded extends MovieCastState {
  final List<Cast> movieCast;

  MovieCastLoaded(this.movieCast);
}

class MovieCastError extends MovieCastState {
  final String message;

  MovieCastError(this.message);
}