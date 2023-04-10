import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/movie_response.dart';

part 'recommended_movie_state.dart';

class RecommendedMovieBloc extends Cubit<RecommendedMovieState>  {

  final ApiProvider _apiService;

  RecommendedMovieBloc(this._apiService) : super(RecommendedMovieInitial());

  Future<void> fetchMovies() async {
    try {
      final movies = await _apiService.fetchRecommendedMovies();
      emit(RecommendedMovieLoaded(movies));
    } catch (error) {
      emit(RecommendedMovieError(error.toString()));
    }
  }
}