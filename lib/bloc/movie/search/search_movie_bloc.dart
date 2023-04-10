import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/movie_response.dart';

part 'search_movie_state.dart';

class SearchMovieBloc extends Cubit<SearchMovieState>  {

  final ApiProvider _apiService;

  SearchMovieBloc(this._apiService) : super(SearchMovieInitial());

  Future<void> fetchMovies(String query) async {
    try {
      final movies = await _apiService.fetchSearchedMovie(query);
      emit(SearchMovieLoaded(movies));
    } catch (error) {
      emit(SearchMovieError(error.toString()));
    }
  }
}