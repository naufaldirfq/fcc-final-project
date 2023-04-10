import 'package:fcc_final_project/data/model/movie_cast_response.dart';
import 'package:fcc_final_project/data/model/movie_response.dart';
import 'package:mekari_network/mekari_network.dart';

import '../../values/shared.dart';
import '../model/movie_detail_response.dart';

class ApiProvider {
  MKRNetwork get mkrNetwork => _mkrNetwork();

  MKRNetwork _mkrNetwork() {
    final options = NetworkOptions(baseUrl);
    final inspectorConfig = NetworkInspectorConfig(appNavigatorKey);
    var mkrNetwork = MKRNetwork.withOptions(options,
        networkInspectorConfig: inspectorConfig);
    return mkrNetwork;
  }

  Future<List<String>> fetchGenres() async {
    try {
      final response = await mkrNetwork.get('genre/movie/list', queryParameters: {'api_key': apiKey});
      // final response = await mkrNetwork.get('https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey');
      final List<dynamic> data = response.data['genres'];
      final List<String> genres = data.map((genre) => genre['name'].toString()).toList();
      return genres;
    } catch (error) {
      throw Exception('Failed to load genres: $error');
    }
  }

  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await _mkrNetwork().get('movie/now_playing',
          queryParameters: {
            'api_key': apiKey,
          });

      if (response.statusCode == 200) {
        final List<Movie> movies = [];
        for (var movieJson in response.data['results']) {
          final movie = Movie.fromJson(movieJson);
          movies.add(movie);
        }
        return movies;
      } else {
        throw Exception('Failed to fetch movies');
      }
    } catch (error) {
      throw Exception('Failed to fetch movies: $error');
    }
  }

  Future<List<Movie>> fetchRecommendedMovies() async {
    try {
      final response = await _mkrNetwork().get('movie/popular',
          queryParameters: {
            'api_key': apiKey,
          });

      if (response.statusCode == 200) {
        final List<Movie> movies = [];
        for (var movieJson in response.data['results']) {
          final movie = Movie.fromJson(movieJson);
          movies.add(movie);
        }
        return movies;
      } else {
        throw Exception('Failed to fetch movies');
      }
    } catch (error) {
      throw Exception('Failed to fetch movies: $error');
    }
  }

  Future<MovieDetail> fetchMovieDetail(String id) async {
    try {
      final response = await _mkrNetwork().get('movie/$id}',
          queryParameters: {
            'api_key': apiKey,
          });

      if (response.statusCode == 200) {
        final movieDetail = MovieDetail.fromJson(response.data);
        return movieDetail;
      } else {
        throw Exception('Failed to fetch movies');
      }
    } catch (error) {
      throw Exception('Failed to fetch movies: $error');
    }
  }

  Future<List<Cast>> fetchMovieCast(String id) async {
    try {
      final response = await _mkrNetwork().get('movie/$id/credits',
          queryParameters: {
            'api_key': apiKey,
          });

      if (response.statusCode == 200) {
        final List<Cast> casts = [];
        for (var castJson in response.data['cast']) {
          final cast = Cast.fromJson(castJson);
          casts.add(cast);
        }
        return casts;
      } else {
        throw Exception('Failed to fetch casts');
      }
    } catch (error) {
      throw Exception('Failed to fetch casts: $error');
    }
  }

  Future<List<Movie>> fetchSearchedMovie(String query) async {
    try {
      final response = await _mkrNetwork().get('search/movie',
          queryParameters: {
            'api_key': apiKey,
            'query': query
          });

      if (response.statusCode == 200) {
        final List<Movie> movies = [];
        for (var movieJson in response.data['results']) {
          final movie = Movie.fromJson(movieJson);
          movies.add(movie);
        }
        return movies;
      } else {
        throw Exception('Failed to fetch movies');
      }
    } catch (error) {
      throw Exception('Failed to fetch movies: $error');
    }
  }
}
