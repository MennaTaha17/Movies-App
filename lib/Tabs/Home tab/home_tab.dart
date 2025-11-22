import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'Views/first_view.dart';
import 'Views/second_view.dart';
import '../../providers/home_provider.dart';

///Mark Gamal
///Mark Gamal
///Mark Gamal
///Mark Gamal
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  static const String routeName = '/homeTab';

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    final currentGenre = provider.currentGenre;
    final genreMovies = provider.genreMovies[currentGenre] ?? [];

    return Scaffold(
      body:
          provider.isLoading
              ? const Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor),
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    FirstView(movies: provider.latestMovies),
                    SecondView(movies: genreMovies, genre: currentGenre),
                  ],
                ),
              ),
    );
  }
}
