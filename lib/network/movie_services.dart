import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';

class MovieService {
  static const String _baseUrl = 'https://yts.lt/api/v2/list_movies.json';
  static const String _detailsUrl = 'https://yts.lt/api/v2/movie_details.json';
  Future<List<MovieModel>> fetchMovies() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final moviesJson = data['data']['movies'] as List;
      return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
  Future<MovieModel> fetchMovieDetails(int id) async {
    final response = await http.get(
      Uri.parse('$_detailsUrl?movie_id=$id&with_images=true'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final movieJson = data['data']['movie'];
      return MovieModel.fromJson(movieJson);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
