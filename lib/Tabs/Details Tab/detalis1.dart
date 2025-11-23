import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//Shahd Ahmed
//Shahd Ahmed
//Shahd Ahmed
//Shahd Ahmed
//Shahd Ahmed
//Shahd Ahmed
class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late String selectedMovie;
  List castList = [];
  List genreList = [];
  bool loading = true;

   String apiKey = "YOUR_TMDB_API_KEY";

  Map<String, int> movieIds = {
    "Doctor Strange 2": 453395,
    "Iron Man": 1726,
  };

  @override
  void initState() {
    super.initState();
    selectedMovie = widget.movieName;
    fetchMovieData();
  }

  Future<void> fetchMovieData() async {
    setState(() => loading = true);

    int movieId = movieIds[selectedMovie]!;

    final creditsUrl =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey";
    final genresUrl =
        "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey";

    final castRes = await http.get(Uri.parse(creditsUrl));
    final genreRes = await http.get(Uri.parse(genresUrl));

    var castJson = json.decode(castRes.body)["cast"];
    var movieJson = json.decode(genreRes.body)["genres"];

    setState(() {
      castList = castJson.take(10).toList();
      genreList = movieJson.map((e) => e["name"]).toList();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(selectedMovie),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton(
                value: selectedMovie,
                dropdownColor: Colors.black,
                items: movieIds.keys
                    .map(
                      (movieName) => DropdownMenuItem(
                    value: movieName,
                    child: Text(movieName,
                        style: TextStyle(color: Colors.white)),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  selectedMovie = value!;
                  fetchMovieData();
                },
              ),
              const SizedBox(height: 20),

              loading
                  ? Center(
                  child: CircularProgressIndicator(color: Colors.white))
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  barTitle("Cast"),
                  const SizedBox(height: 15),
                  ...castList.map((c) => castBox(c)).toList(),
                  const SizedBox(height: 20),
                  barTitle("Genres"),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: genreList
                        .map<Widget>((g) => genreBox(g))
                        .toList(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget barTitle(String text) {
    return Container(
      width: 373,
      height: 46,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child:
      Text(text, style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }

  Widget castBox(dynamic c) {
    return Container(
      width: 388,
      height: 98,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500${c["profile_path"]}",
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.person, color: Colors.white, size: 70),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name : ${c["name"]}",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text("Character : ${c["character"]}",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget genreBox(String g) {
    return Container(
      width: 122,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(g, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}

class MovieDetailsPage extends StatefulWidget {
  final String movieName;
  const MovieDetailsPage({required this.movieName, Key? key}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}
