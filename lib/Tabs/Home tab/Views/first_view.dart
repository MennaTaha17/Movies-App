import 'package:flutter/material.dart';

import '../../../common/Theme/app_colors.dart';
import '../../../common/Widget/movie_card_home.dart';
import '../../../gen/assets.gen.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 645,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.asstes.images.png.grayScreen.path),
          fit: BoxFit.cover,
        ),
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
                itemCount: 5,
                controller: PageController(
                  viewportFraction: 0.6,
                  initialPage: 1,
                ),
                itemBuilder: (BuildContext context, int index) => MovieCardHome(),
              ),
            ),
            Assets.asstes.images.png.homeCenter.image(),
          ],
        ),
      ),
    );
  }
}
