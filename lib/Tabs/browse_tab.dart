import 'package:flutter/material.dart';

import '../model/movies_model.dart';
import '../network/movies_services.dart';
///shahd Yasser
///shahd Yasser
///shahd Yasser
///shahd Yasser
///shahd Yasser

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final MoviesService _service = MoviesService();

  final List<String> tabs = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
  ];

  int selectedIndex = 0;

  List<MovieModel> movies = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasError = false;
  int currentPage = 1;
  int totalPages = 1;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMovies(refresh: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300 &&
          !isLoadingMore &&
          !isLoading &&
          currentPage < totalPages) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMovies({bool refresh = false}) async {
    setState(() {
      if (refresh) {
        isLoading = true;
        movies = [];
        currentPage = 1;
        totalPages = 1;
      } else {
        isLoadingMore = true;
      }
      hasError = false;
    });

    try {
      final category = tabs[selectedIndex];
      final pageToLoad = refresh ? 1 : currentPage + 1;

      final res = await _service.searchMovies(category, page: pageToLoad);

      // SAFE PARSING
      final fetchedMovies = (res['movies'] as List?)
          ?.map((e) => MovieModel.fromJson(e))
          .toList() ??
          [];

      final fetchedPage = res['page'] ?? 1;
      final fetchedTotal = res['total_pages'] ?? 1;

      setState(() {
        if (refresh) {
          movies = fetchedMovies;
        } else {
          movies.addAll(fetchedMovies);
        }
        currentPage = fetchedPage;
        totalPages = fetchedTotal;
      });
    } catch (e) {
      setState(() => hasError = true);
    } finally {
      setState(() {
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (currentPage >= totalPages) return;

    setState(() => isLoadingMore = true);

    try {
      final category = tabs[selectedIndex];
      final nextPage = currentPage + 1;

      final res = await _service.searchMovies(category, page: nextPage);

      final fetchedMovies = (res['movies'] as List?)
          ?.map((e) => MovieModel.fromJson(e))
          .toList() ??
          [];

      final fetchedPage = res['page'] ?? nextPage;

      setState(() {
        movies.addAll(fetchedMovies);
        currentPage = fetchedPage;
      });
    } catch (_) {} finally {
      setState(() => isLoadingMore = false);
    }
  }

  Future<void> _onRefresh() async {
    await _fetchMovies(refresh: true);
  }

  void _onTabSelected(int idx) {
    if (idx == selectedIndex) return;

    setState(() => selectedIndex = idx);

    _fetchMovies(refresh: true);

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Browse',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 64,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = index == selectedIndex;

                  return GestureDetector(
                    onTap: () => _onTabSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFFBB3B)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFFBB3B),
                          width: 2,
                        ),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 6,
                          )
                        ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: Builder(builder: (context) {
                  if (isLoading && movies.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: Color(0xFFFFBB3B)),
                    );
                  }

                  if (hasError && movies.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Error loading movies',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _onRefresh,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFBB3B),
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (movies.isEmpty) {
                    return const Center(
                      child: Text(
                        'No movies found',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.64,
                    ),
                    itemCount: movies.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, i) {
                      if (i >= movies.length) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFFFFBB3B)),
                        );
                      }

                      final movie = movies[i];
                      return MovieCard(movie: movie);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  const MovieCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.posterFullUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: const Color(0xFF282A28),
                child: const Center(
                  child:
                  CircularProgressIndicator(color: Color(0xFFFFBB3B)),
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
                    size: 36,
                  ),
                ),
              );
            },
          ),

          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    size: 14,
                    color: Color(0xFFFFBB3B),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    movie.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}