import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/common/Widget/custom_main_button.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/screens/movie_details/button_states.dart';
import 'package:movies/screens/movie_details/poster_details.dart';
import 'package:movies/screens/movie_details/secreenshots.dart';
import 'package:movies/tabs/profile_tab/profile_tab.dart';
import 'package:provider/provider.dart';
import '../../common/Widget/buid_tab_button.dart';
import '../../network/movie_services.dart';
import '../../providers/watch_list_provider.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = "/movie_details_screen";

  final int movieId;
  const MovieDetails({super.key, required this.movieId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  final MovieService movieService = MovieService();
  late Future<MovieModel> futureMovie;

  @override
  void initState() {
    super.initState();
    futureMovie = movieService.fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: FutureBuilder<MovieModel>(
          future: futureMovie,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Movie not found'));
            }

            final movie = snapshot.data!;
            final watchListPro = context.read<WatchListProvider>();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PosterDetails(movie: movie),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomMainButton(
                            text: 'Watch',
                            color: AppColors.redColor,
                            textColor: AppColors.whiteColor,
                            onPressed: () {
                              watchListPro.addToWatchList(movie);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.greenColor,
                                  content:
                                  Text('${movie.title} added to Watch List'),
                                ),
                              );
                              Navigator.pushNamed(
                                  context, ProfileTab.routeName);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonStates(
                          icon: Icons.favorite,
                          text: movie.likes.toString(),
                        ),
                        ButtonStates(
                          icon: Icons.timelapse,
                          text: movie.views.toString(),
                        ),
                        ButtonStates(
                          icon: Icons.star,
                          text: movie.rating.toString(),
                        ),
                      ],
                    ),
                  ),
                  MovieScreenshots(movie: movie),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
