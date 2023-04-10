import 'package:fcc_final_project/data/model/movie_cast_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cast model', () {
    test('fromJson creates a Cast object', () {
      final json = {
        'adult': true,
        'gender': 2,
        'id': 123,
        'known_for_department': 'Acting',
        'name': 'John Doe',
        'original_name': 'John Doe',
        'popularity': 7.8,
        'profile_path': '/abc.jpg',
        'cast_id': 456,
        'character': 'Bob',
        'credit_id': 'xyz',
        'order': 1,
      };

      final cast = Cast.fromJson(json);

      expect(cast.adult, equals(true));
      expect(cast.gender, equals(2));
      expect(cast.id, equals(123));
      expect(cast.knownForDepartment, equals('Acting'));
      expect(cast.name, equals('John Doe'));
      expect(cast.originalName, equals('John Doe'));
      expect(cast.popularity, equals(7.8));
      expect(cast.profilePath, equals('/abc.jpg'));
      expect(cast.castId, equals(456));
      expect(cast.character, equals('Bob'));
      expect(cast.creditId, equals('xyz'));
      expect(cast.order, equals(1));
    });
  });
}
