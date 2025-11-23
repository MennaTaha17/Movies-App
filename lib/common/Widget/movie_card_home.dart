import 'package:flutter/material.dart';
import '../../model/movie_model.dart';
import '../../screens/movie_details/movie_details.dart';
import '../Theme/app_colors.dart';

class MovieCardHome extends StatelessWidget {
  final MovieModel movie;
  const MovieCardHome({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MovieDetails.routeName,
          arguments: movie.id,
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.poster.isNotEmpty
                  ? movie.poster
                  : 'https://via.placeholder.com/150',
              width: 200,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 9, top: 11),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
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
      ),
    );
  }
}