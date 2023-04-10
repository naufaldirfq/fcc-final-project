import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'genre_state.dart';

class GenreBloc extends Cubit<GenreState>  {

  final ApiProvider _apiService;

  GenreBloc(this._apiService) : super(GenresInitial());

  Future<void> fetchGenres() async {
    try {
      final genres = await _apiService.fetchGenres();
      emit(GenresLoaded(genres));
    } catch (error) {
      emit(GenresError(error.toString()));
    }
  }
}