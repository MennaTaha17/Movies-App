import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/screens/movie_details/poster_image.dart';
import 'package:provider/provider.dart';

import '../../providers/watch_list_provider.dart';
import '../../tabs/profile_tab/profile_tab.dart';

class PosterDetails extends StatefulWidget {
  final MovieModel movie;

  const PosterDetails({super.key, required this.movie});

  @override
  State<PosterDetails> createState() => _PosterDetailsState();
}

class _PosterDetailsState extends State<PosterDetails> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final watchListPro = context.watch<WatchListProvider>();
    isSelected = watchListPro.history.contains(widget.movie);

    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: PosterImage(movieModel: widget.movie),
          ),
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.95),
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                ],
                stops: [0.0, 0.2, 1.0],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 40,
                    color: AppColors.whiteColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final watchListPro = context.read<WatchListProvider>();
                    if (!isSelected) {
                      watchListPro.addToHistory(widget.movie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.greenColor,
                          content: Text(
                            '${widget.movie.title} added to History',
                          ),
                        ),
                      );
                    }
                    setState(() {
                      isSelected = true;
                    });
                    Navigator.pushNamed(context, ProfileTab.routeName);
                    },
                  icon: Icon(
                    isSelected ? Icons.bookmark : Icons.bookmark_border,
                    size: 40,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 160,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.yellowColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.yellowColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.movie.title.isNotEmpty
                      ? widget.movie.title
                      : "No Title",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.movie.releaseData.isNotEmpty
                      ? widget.movie.releaseData.split("-")[0]
                      : "Unknown",
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
