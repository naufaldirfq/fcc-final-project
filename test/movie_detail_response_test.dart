import 'package:fcc_final_project/data/model/movie_detail_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieDetail', () {
    test('fromJson should create a MovieDetail object from a JSON map', () {
      final json = {
        'adult': false,
        'backdrop_path': '/abc.jpg',
        'budget': 10000000,
        'homepage': 'https://www.example.com',
        'id': 123,
        'imdb_id': 'tt1234567',
        'original_language': 'en',
        'original_title': 'The Original Title',
        'overview': 'Overview',
        'popularity': 7.8,
        'poster_path': '/def.jpg',
        'release_date': '2023-04-05',
        'revenue': 20000000,
        'runtime': 120,
        'status': 'Released',
        'tagline': 'The Tagline',
        'title': 'The Title',
        'video': false,
        'vote_average': 8.0,
        'vote_count': 1000,
      };

      final movieDetail = MovieDetail.fromJson(json);

      expect(movieDetail.adult, equals(false));
      expect(movieDetail.backdropPath, equals('/abc.jpg'));
      expect(movieDetail.budget, equals(10000000));
      expect(movieDetail.homepage, equals('https://www.example.com'));
      expect(movieDetail.id, equals(123));
      expect(movieDetail.imdbId, equals('tt1234567'));
      expect(movieDetail.originalLanguage, equals('en'));
      expect(movieDetail.originalTitle, equals('The Original Title'));
      expect(movieDetail.overview, equals('Overview'));
      expect(movieDetail.popularity, equals(7.8));
      expect(movieDetail.posterPath, equals('/def.jpg'));
      expect(movieDetail.releaseDate, equals('2023-04-05'));
      expect(movieDetail.revenue, equals(20000000));
      expect(movieDetail.runtime, equals(120));
      expect(movieDetail.status, equals('Released'));
      expect(movieDetail.tagline, equals('The Tagline'));
      expect(movieDetail.title, equals('The Title'));
      expect(movieDetail.video, equals(false));
      expect(movieDetail.voteAverage, equals(8.0));
      expect(movieDetail.voteCount, equals(1000));
    });
  });
}
