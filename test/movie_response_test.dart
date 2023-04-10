import 'package:fcc_final_project/data/model/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Movie', () {
    test('fromJson() should parse JSON correctly', () {
      final json = {
        'adult': false,
        'backdrop_path': '/abc.jpg',
        'genre_ids': [1, 2, 3],
        'id': 123,
        'original_language': 'en',
        'original_title': 'Original Title',
        'overview': 'Overview',
        'popularity': 123.45,
        'poster_path': '/def.jpg',
        'release_date': '2023-04-05',
        'title': 'Title',
        'video': false,
        'vote_average': 7.8,
        'vote_count': 1234,
      };

      final movie = Movie.fromJson(json);

      expect(movie.adult, false);
      expect(movie.backdropPath, '/abc.jpg');
      expect(movie.genreIds, [1, 2, 3]);
      expect(movie.id, 123);
      expect(movie.originalLanguage, 'en');
      expect(movie.originalTitle, 'Original Title');
      expect(movie.overview, 'Overview');
      expect(movie.popularity, 123.45);
      expect(movie.posterPath, '/def.jpg');
      expect(movie.releaseDate, '2023-04-05');
      expect(movie.title, 'Title');
      expect(movie.video, false);
      expect(movie.voteAverage, 7.8);
      expect(movie.voteCount, 1234);
    });
  });
}
