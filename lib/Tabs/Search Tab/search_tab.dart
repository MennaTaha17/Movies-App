import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
///Shahd Ahmed
class Movie {
  final String title;
  final String imagePath;

  Movie({required this.title, required this.imagePath});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _filteredMovies = [];
  bool loading = false;

   String apiKey = "YOUR_TMDB_API_KEY"; // ضع هنا الـ API Key الخاص بك

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() => _filteredMovies = []);
      return;
    }

    setState(() => loading = true);

    try {
      final url =
          "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List results = data["results"];

        List<Movie> movies = results.map((movie) {
          return Movie(
            title: movie["title"] ?? "",
            imagePath: movie["poster_path"] != null
                ? "https://image.tmdb.org/t/p/w500${movie["poster_path"]}"
                : "",
          );
        }).toList();

        setState(() {
          _filteredMovies = movies;
          loading = false;
        });
      } else {
        setState(() => loading = false);
        print("Error: ${res.statusCode}");
      }
    } catch (e) {
      setState(() => loading = false);
      print("Exception: $e");
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    searchMovies(query);
  }

  @override
  Widget build(BuildContext context) {
    const double searchBarHeight = 55.7;
    const double searchIconSize = 24.0;
    const double searchTextSize = 16.0;
    const double iconLeftPadding = 16.0;
    const double iconTextSpacing = 15.0;

    bool showLogo = _searchController.text.isEmpty && _filteredMovies.isEmpty;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Container(
                height: searchBarHeight,
                width: 398,
                decoration: BoxDecoration(
                  color: AppColors.grayColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: iconLeftPadding),
                    const Icon(Icons.search,
                        size: searchIconSize, color: AppColors.whiteColor),
                    const SizedBox(width: iconTextSpacing),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                            fontSize: searchTextSize,
                            color: AppColors.whiteColor),
                        cursorColor: AppColors.whiteColor,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              fontSize: searchTextSize,
                              color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: loading
                  ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
                  : showLogo
                  ? const Center(
                child: SizedBox(
                  width: 124,
                  height: 124,
                  child: Image(
                    image: AssetImage(
                        'asstes/images/png/popcorn1.png'),
                  ),
                ),
              )
                  : _filteredMovies.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "No movies found",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
                  : Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0),
                child: GridView.builder(
                  itemCount: _filteredMovies.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final movie = _filteredMovies[index];
                    return SizedBox(
                      width: 189,
                      height: 279,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: movie.imagePath.isEmpty
                            ? Container(
                          color: Colors.transparent,
                        )
                            : Image.network(
                          movie.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}