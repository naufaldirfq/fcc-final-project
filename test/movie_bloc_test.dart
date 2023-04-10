import 'package:fcc_final_project/bloc/movie/movie_bloc.dart';
import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiProvider extends Mock implements ApiProvider {}

void main() {
  group('MovieState', () {
    test('MovieInitial is a subclass of MovieState', () {
      expect(MovieInitial() is MovieState, equals(true));
    });

    test('MovieLoaded is a subclass of MovieState', () {
      expect(MovieLoaded([]) is MovieState, equals(true));
    });

    test('MovieError is a subclass of MovieState', () {
      expect(MovieError('Error') is MovieState, equals(true));
    });
  });
}