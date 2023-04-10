import 'package:fcc_final_project/bloc/genre/genre_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenreState', () {
    test('GenresInitial is a subclass of GenreState', () {
      expect(GenresInitial() is GenreState, equals(true));
    });

    test('GenresLoaded is a subclass of GenreState', () {
      expect(GenresLoaded([]) is GenreState, equals(true));
    });

    test('GenresError is a subclass of GenreState', () {
      expect(GenresError('Error') is GenreState, equals(true));
    });
  });
}