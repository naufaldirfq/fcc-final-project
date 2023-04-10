import 'package:fcc_final_project/data/model/movie_detail_response.dart';
import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Cubit<MovieDetailState>  {

  final ApiProvider _apiService;

  MovieDetailBloc(this._apiService) : super(MovieDetailInitial());

  Future<void> fetchMovies(String id) async {
    try {
      final movies = await _apiService.fetchMovieDetail(id);
      emit(MovieDetailLoaded(movies));
    } catch (error) {
      emit(MovieDetailError(error.toString()));
    }
  }
}