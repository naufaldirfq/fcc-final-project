import 'package:fcc_final_project/data/model/movie_detail_response.dart';
import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/movie_cast_response.dart';

part 'movie_cast_state.dart';

class MovieCastBloc extends Cubit<MovieCastState>  {

  final ApiProvider _apiService;

  MovieCastBloc(this._apiService) : super(MovieCastInitial());

  Future<void> fetchMovieCast(String id) async {
    try {
      final movies = await _apiService.fetchMovieCast(id);
      emit(MovieCastLoaded(movies));
    } catch (error) {
      emit(MovieCastError(error.toString()));
    }
  }
}