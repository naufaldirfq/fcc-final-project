part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailLoaded(this.movieDetail);
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);
}