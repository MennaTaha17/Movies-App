import 'package:flutter/material.dart';
import '../../../common/Theme/app_colors.dart';
import '../../../common/Widget/movie_card_home.dart';
import '../../../model/home_movie_model.dart';

class SecondView extends StatelessWidget {
  const SecondView({super.key, required this.movies, required this.genre});
  final List<MovieModel> movies;
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Assets.asstes.images.png.homeCenter.image(),
        Row(
          children: [
            Text(
              "$genre",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/browseScreen');
              },
              child: Row(
                spacing: 5,
                children: [
                  Text(
                    "See More",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.yellowColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.yellowColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child:
              movies.isEmpty
                  ? Center(
                    child: Text(
                      "No movies",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  )
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            width: 146,
                            height: 220,
                            child: GestureDetector(
                              // onTap: () {   //TODO:Navigator
                              //   Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //       builder: (_) => MovieDetailScreen(movie: widget.movies[index]),
                              //     ),
                              //   );
                              // },

                              child: MovieCardHome(movie: movies[index]),
                            ),
                          ),
                        ),
                  ),
        ),
      ],
    );
  }
}
