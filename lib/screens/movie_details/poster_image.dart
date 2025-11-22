import 'package:flutter/material.dart';
import 'package:movies/model/movie_model.dart';


class PosterImage extends StatelessWidget {
  final MovieModel movieModel;

  const PosterImage({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      movieModel.poster.isNotEmpty ? movieModel.poster : 'https://via.placeholder.com/150',
      width: double.infinity,
      height: 350,
      fit: BoxFit.cover,
    );
  }
}
