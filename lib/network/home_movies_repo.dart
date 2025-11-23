import '../model/home_movie_model.dart';
import 'home_movies_services.dart';


class MoviesRepo {
  final MoviesService service = MoviesService();

  Future<List<MovieModel>> getLatestMovies({int limit = 10}) async {
    final response = await service.listMovies(
      limit: limit,
      sortBy: "date_added",
    );
    final list = response.data["data"]["movies"] as List;
    return list.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<List<MovieModel>> getMoviesByGenre({
    required String genre,
    int limit = 20,
  }) async {
    final response = await service.listMovies(genre: genre, limit: limit);
    final data = response.data["data"];
    if (data == null || data["movies"] == null) return [];
    final list = data["movies"] as List;
    return list.map((e) => MovieModel.fromJson(e)).toList();
  }
}
