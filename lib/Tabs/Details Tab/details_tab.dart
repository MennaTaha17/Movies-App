
import 'package:flutter/material.dart';

import '../../model/movies_model.dart';
import '../../network/movies_services.dart';


class DetailsScreen extends StatefulWidget {
  final MovieModel movie;
  final String heroTag;

  const DetailsScreen({
    required this.movie,
    required this.heroTag,
    super.key,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final MoviesService _service = MoviesService();
  MovieModel? _fullMovieDetails;
  bool _isLoadingDetails = true;
  bool _hasErrorDetails = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    setState(() {
      _isLoadingDetails = true;
      _hasErrorDetails = false;
    });
    try {
      final details = await _service.getMovieDetails(widget.movie.id);
      setState(() {
        _fullMovieDetails = details;
      });
    } catch (e) {
      setState(() {
        _hasErrorDetails = true;
      });
    } finally {
      setState(() {
        _isLoadingDetails = false;
      });
    }
  }

  void _onWatchTapped() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Playing movie... (Feature coming soon)')),
    );
  }

  void _onSaveTapped() {
    setState(() {
      _isSaved = !_isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Movie saved!' : 'Movie unsaved.'),
      ),
    );
  }

  String _formatRuntime(int? minutes) {
    if (minutes == null || minutes == 0) return 'N/A';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours > 0) {
      return '${hours}h ${remainingMinutes}m';
    }
    return '${remainingMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final displayMovie = _fullMovieDetails ?? widget.movie;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: const Color(0xFFFFBB3B),
              size: 28,
            ),
            onPressed: _onSaveTapped,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image with Play Button Overlay
            SizedBox(
              height: 450,
              width: double.infinity,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.heroTag,
                    child: Image.network(
                      displayMovie.posterFullUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: const Color(0xFF282A28),
                          child: const Center(
                            child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
                          ),
                        );
                      },
                      errorBuilder: (context, err, st) {
                        return Container(
                          color: const Color(0xFF282A28),
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white54,
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Play button overlay
                  Center(
                    child: GestureDetector(
                      onTap: _onWatchTapped,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.yellow.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  Text(
                    displayMovie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Release Year
                  Text(
                    displayMovie.releaseYear,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Watch Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _onWatchTapped,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      label: const Text(
                        'Watch',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Stats (Likes, Duration, Rating)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(Icons.favorite, '15', 'Likes'), // ⬅️ الإعجابات
                      _buildStatItem(Icons.access_time, _formatRuntime(displayMovie.runtime), 'Duration'), // المدة
                      _buildStatItem(Icons.star, displayMovie.rating.toStringAsFixed(1), 'Rating'), //  التقييم
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Overview
                  const Text(
                    'Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.white24, height: 20),
                  _isLoadingDetails && _fullMovieDetails == null
                      ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
                  )
                      : _hasErrorDetails
                      ? const Center(
                    child: Text(
                      'Error loading details.',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                      : Text(
                    displayMovie.overview.isNotEmpty
                        ? displayMovie.overview
                        : 'No overview available for this movie.',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for building stat items
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}