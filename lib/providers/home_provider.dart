import 'package:flutter/material.dart';
import '../model/home_movie_model.dart';
import '../network/home_movies_repo.dart';

class HomeProvider extends ChangeNotifier {
  final repo = MoviesRepo();

  final List<String> genres = ["Action", "Adventure", "Animation", "Biography"];

  final Map<String, List<MovieModel>> genreMovies = {};

  List<MovieModel> latestMovies = [];
  bool isLoading = false;

  int currentGenreIndex = 0;
  String get currentGenre => genres[currentGenreIndex];

  Future<void> loadHomeData({bool forceRefreshGenres = false}) async {
    isLoading = true;
    notifyListeners();

    latestMovies = await repo.getLatestMovies(limit: 10);

    if (forceRefreshGenres || !genreMovies.containsKey(currentGenre)) {
      genreMovies[currentGenre] = await repo.getMoviesByGenre(
        genre: currentGenre,
        limit: 20,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> rotateGenre() async {
    currentGenreIndex = (currentGenreIndex + 1) % genres.length;
    notifyListeners();
    if (!genreMovies.containsKey(currentGenre)) {
      genreMovies[currentGenre] = await repo.getMoviesByGenre(
        genre: currentGenre,
        limit: 20,
      );
    }
    notifyListeners();
  }

  Future<void> setGenreIndex(int idx) async {
    if (idx < 0 || idx >= genres.length) return;
    currentGenreIndex = idx;
    if (!genreMovies.containsKey(currentGenre)) {
      genreMovies[currentGenre] = await repo.getMoviesByGenre(
        genre: currentGenre,
        limit: 20,
      );
    }
    notifyListeners();
  }
}
