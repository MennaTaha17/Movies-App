
import 'package:dio/dio.dart';

import '../model/movies_model.dart';


class MoviesService {
  final Dio _dio = Dio();
  final String apiKey = 'YOUR_TMDB_API_KEY_HERE';
  final String base = 'https://api.themoviedb.org/3';


  Future<Map<String, dynamic>> searchMovies(String query, {int page = 1}) async {

    try {
      final url = '$base/search/movie';

      final resp = await _dio.get(
        url,
        queryParameters: {
          'api_key': apiKey,
          'query': query,
          'page': page,
          'include_adult': false,
          'language': 'en-US',
        },
      );

      final data = resp.data;

      final List results = data['results'] ?? [];

      final movies = results
          .map((item) => MovieModel.fromJson(item))
          .toList();

      return {
        'movies': movies,
        'page': data['page'] ?? 1,
        'total_pages': data['total_pages'] ?? 1,
      };
    } catch (e) {
      print('❌ Error fetching movies: $e');
      return {
        'movies': [],
        'page': page,
        'total_pages': 1,
      };
    }
  }

  Future<MovieModel?> getMovieDetails(int movieId) async {
    try {
      final url = '$base/movie/$movieId';
      final resp = await _dio.get(
        url,
        queryParameters: {
          'api_key': apiKey,
          'language': 'en-US',
        },
      );

      final data = resp.data;
      if (data != null) {
        return MovieModel(
          id: data['id'] ?? 0,
          title: data['title'] ?? '',
          rating: (data['vote_average'] ?? 0).toDouble(),
          posterPath: data['poster_path'],
          overview: data['overview'] ?? '',
          releaseDate: data['release_date'],
          runtime: data['runtime'],
        );
      }
      return null;
    } catch (e) {
      print('❌ Error fetching movie details for ID $movieId: $e');
      return null;
    }
  }
}