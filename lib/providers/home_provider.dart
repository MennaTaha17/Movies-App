import 'package:flutter/material.dart';
import '../model/movie_model.dart';
import '../network/home_movies_repo.dart';

class HomeProvider extends ChangeNotifier {
  final MoviesRepo repo;

  HomeProvider(this.repo);
  final List<String> genres = ["Action", "Adventure", "Animation", "Biography"];
  final Map<String, List<MovieModel>> genreMovies = {};

  List<MovieModel> latestMovies = [];
  bool isLoading = false;

  int currentGenreIndex = 0;
  String get currentGenre => genres[currentGenreIndex];

  Future<void> loadHomeData({bool forceRefreshGenres = false}) async {
    isLoading = true;
    notifyListeners();

    latestMovies = await repo.getLatestMovies();

    if (forceRefreshGenres || !genreMovies.containsKey(currentGenre)) {
      genreMovies[currentGenre] = await repo.getMoviesByGenre(
        genre: currentGenre,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> setGenreIndex(int idx) async {
    if (idx < 0 || idx >= genres.length) return;
    currentGenreIndex = idx;
    if (!genreMovies.containsKey(currentGenre)) {
      genreMovies[currentGenre] = await repo.getMoviesByGenre(
        genre: currentGenre,
      );
    }
    notifyListeners();
  }

  Future<void> rotateGenre() async {
    currentGenreIndex = (currentGenreIndex + 1) % genres.length;
    notifyListeners();
    if (!genreMovies.containsKey(currentGenre)) {
      genreMovies[currentGenre] = await repo.getMoviesByGenre(
        genre: currentGenre,
      );
    }
    notifyListeners();
  }
}