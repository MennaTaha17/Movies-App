import 'package:flutter/material.dart';
import '../../model/movie_model.dart';

class MovieScreenshots extends StatelessWidget {
  final MovieModel movie;

  const MovieScreenshots({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenshots = [movie.screenshot1, movie.screenshot2, movie.screenshot3];

    return Column(
      children: screenshots.map((url) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              url.isNotEmpty ? url : 'https://via.placeholder.com/150',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}
