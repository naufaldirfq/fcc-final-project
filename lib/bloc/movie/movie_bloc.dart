import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/movie_response.dart';

part 'movie_state.dart';

class MovieBloc extends Cubit<MovieState>  {

  final ApiProvider _apiService;

  MovieBloc(this._apiService) : super(MovieInitial());

  Future<void> fetchMovies() async {
    try {
      final movies = await _apiService.fetchMovies();
      emit(MovieLoaded(movies));
    } catch (error) {
      emit(MovieError(error.toString()));
    }
  }
}