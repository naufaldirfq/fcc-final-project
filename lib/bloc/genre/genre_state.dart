part of 'genre_bloc.dart';

@immutable
abstract class GenreState {}

class GenresInitial extends GenreState {}

class GenresLoaded extends GenreState {
  final List<String> genres;

  GenresLoaded(this.genres);
}

class GenresError extends GenreState {
  final String message;

  GenresError(this.message);
}