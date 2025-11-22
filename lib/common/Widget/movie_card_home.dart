import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

import '../../model/home_movie_model.dart';

class MovieCardHome extends StatelessWidget {
  final MovieModel movie;
  const MovieCardHome({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.image,
            width: 200,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 9, top: 11),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 58,
          height: 28,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                movie.rating.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Icon(Icons.star, color: AppColors.yellowColor),
            ],
          ),
        ),
      ],
    );
  }
}
