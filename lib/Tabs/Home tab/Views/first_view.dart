import 'package:flutter/material.dart';
import '../../../common/Theme/app_colors.dart';
import '../../../common/Widget/movie_card_home.dart';
import '../../../gen/assets.gen.dart';
import '../../../model/home_movie_model.dart';

class FirstView extends StatefulWidget {
  final List<MovieModel> movies;
  const FirstView({super.key, required this.movies});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.6, initialPage: 0);

    _pageController.addListener(() {
      int page = _pageController.page!.round();
      if (page != currentPage) {
        setState(() {
          currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentMovie =
        widget.movies.isNotEmpty ? widget.movies[currentPage] : null;

    return Container(
      width: double.infinity,
      height: 645,
      decoration: BoxDecoration(
        image:
            currentMovie != null
                ? DecorationImage(
                  image: NetworkImage(currentMovie.image),
                  fit: BoxFit.cover,
                )
                : null,
      ),
      child: Container(
        padding: EdgeInsets.only(top: 9),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.blackColor.withValues(alpha: .7),
              AppColors.blackColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Assets.asstes.images.png.homeHader.image(),
            SizedBox(height: 20),
            SizedBox(
              height: 351,
              width: double.infinity,
              child: PageView.builder(
                itemCount: widget.movies.length,
                controller: _pageController,
                itemBuilder: (context, index) {
                  double topPadding = currentPage == index ? 0 : 20;
                  return Padding(
                    padding: EdgeInsets.only(top: topPadding, right: 16),
                    child: GestureDetector(
                      //TODO:Navigator
                      // onTap: () {
                      //   Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: (_) => MovieDetailScreen(movie: widget.movies[index]),
                      //     ),
                      //   );
                      // },
                      child: MovieCardHome(movie: widget.movies[index]),
                    ),
                  );
                },
              ),
            ),
            Assets.asstes.images.png.homeCenter.image(),
          ],
        ),
      ),
    );
  }
}
