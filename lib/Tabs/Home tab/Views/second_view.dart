import 'package:flutter/material.dart';

import '../../../common/Theme/app_colors.dart';
import '../../../common/Widget/movie_card_home.dart';
import '../../../gen/assets.gen.dart';
import '../../../screens/update profile/update_profile.dart';

class SecondView extends StatelessWidget {
  const SecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        // Assets.asstes.images.png.homeCenter.image(),
        Row(
          children: [
            Text(
              "Action ",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamed(UpdateProfile.routeName);
              },
              child: Row(
                children: [
                  Text(
                    "See More",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.yellowColor,
                    ),
                  ),
                  SizedBox(width: 5),

                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.yellowColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder:
                (context, index) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: MovieCardHome(),
            ),
          ),
        ),
      ],
    );
  }
}
