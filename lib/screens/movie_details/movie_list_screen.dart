import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/screens/movie_details/button_states.dart';
import '../../model/movie_model.dart';
import '../../network/movie_services.dart';
import 'movie_details.dart';

class MovieListScreen extends StatefulWidget {
  static const String routeName = "/movie_list_screen";
  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<MovieModel>>(
          future: movieService.fetchMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: AppColors.yellowColor));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No movies found'));
            }
            final movies = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailsScreen.routeName,
                      arguments: movie.id,
                    );
                  },
                  child: Stack(
                    children: [
                      movie.poster.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(movie.poster, fit: BoxFit.cover),
                      )
                          : Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonStates(
                          width: 58,
                          height: 28,
                          text: movie.rating.toString(),
                          icon: Icons.star,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
