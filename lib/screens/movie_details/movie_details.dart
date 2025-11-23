import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/common/Widget/custom_main_button.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/screens/movie_details/button_states.dart';
import 'package:movies/screens/movie_details/poster_details.dart';
import 'package:movies/screens/movie_details/poster_image.dart';
import 'package:movies/screens/movie_details/secreenshots.dart';
import '../../network/movie_services.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = "/movie_details_screen";

  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context)!.settings.arguments as int;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: FutureBuilder<MovieModel>(
          future: movieService.fetchMovieDetails(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColors.yellowColor,));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Movie not found'));
            }
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 PosterDetails(movie: movie),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomMainButton(
                      text: 'Watch',
                      color: AppColors.redColor,
                      textColor: AppColors.whiteColor,
                      onPressed: () {},
                    )
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
                  MovieScreenshots(movie: movie,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
