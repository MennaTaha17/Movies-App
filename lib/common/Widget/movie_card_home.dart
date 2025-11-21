import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

import '../../gen/assets.gen.dart';

class MovieCardHome extends StatelessWidget {
  const MovieCardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Assets.asstes.images.png.grayScreen.image(),
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
                "7.7",
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
