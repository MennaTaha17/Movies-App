import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';

class MoviesRepo {
  Future<List<MovieModel>> getLatestMovies({int limit = 10}) async {
    final response = await http.get(
      Uri.parse(
        'https://yts.lt/api/v2/list_movies.json?limit=$limit&sort_by=date_added',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final moviesJson = data['data']['movies'] as List?;
      if (moviesJson == null) return [];
      return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<MovieModel>> getMoviesByGenre({
    required String genre,
    int limit = 20,
  }) async {
    final response = await http.get(
      Uri.parse(
        'https://yts.lt/api/v2/list_movies.json?genre=$genre&limit=$limit',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final moviesJson = data['data']['movies'] as List?;
      if (moviesJson == null) return [];
      return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}