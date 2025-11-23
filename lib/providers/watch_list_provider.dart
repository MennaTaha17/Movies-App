
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/movie_model.dart';



class WatchListProvider extends ChangeNotifier {
  List<MovieModel> watchList = [];
 List<MovieModel> history = [];
  void addToWatchList(MovieModel movieModel) {
    watchList.add(movieModel);
    notifyListeners();
  }
  void addToHistory(MovieModel movie) {
    if (!history.contains(movie)) {
      history.add(movie);
      notifyListeners();
    }
  }
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('watchList', jsonEncode(watchList.map((e) => e.toJson()).toList()));
    prefs.setString('history', jsonEncode(history.map((e) => e.toJson()).toList()));
  }
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final watchListString = prefs.getString('watchList');
    final historyString = prefs.getString('history');

    if (watchListString != null) {
      final decoded = jsonDecode(watchListString) as List;
      watchList = decoded.map((e) => MovieModel.fromJson(e)).toList();
    }
    if (historyString != null) {
      final decoded = jsonDecode(historyString) as List;
      history = decoded.map((e) => MovieModel.fromJson(e)).toList();
    }
    notifyListeners();
  }
}
