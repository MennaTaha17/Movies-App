import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/screens/update%20profile/update_profile.dart';

import '../../common/Widget/movie_card_home.dart';
import '../../gen/assets.gen.dart';
import 'Views/first_view.dart';
import 'Views/second_view.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  static const String routeName = '/homeTab';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              FirstView(),
              SecondView(),
            ],
          ),
        ),
      ),
    );
  }
}
