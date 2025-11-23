
import 'package:flutter/material.dart';
import 'package:movies/common/Widget/buid_tab_button.dart';
import 'package:movies/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

import '../../common/Theme/app_colors.dart';
import '../../common/Widget/custom_main_button.dart';
import '../../gen/assets.gen.dart';
import '../../providers/settings_provider.dart';
import '../../providers/watch_list_provider.dart';
import '../../screens/update profile/update_profile.dart';
import 'header_profile.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = '/profile_tab';
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool showWatchList = true;

  @override
  Widget build(BuildContext context) {
    final watchListPro = context.watch<WatchListProvider>();
    final avatarPro = context.watch<SettingsProvider>();

    final currentList =
    showWatchList ? watchListPro.watchList : watchListPro.history;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 180,
                child: HeaderProfile()),
            SizedBox(
              height: 90,
              child: Container(
                color: AppColors.grayColor,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomMainButton(
                        text: 'Edit profile',
                        color: AppColors.yellowColor,
                        textColor: AppColors.blackColor,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            UpdateProfile.routeName,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: CustomMainButton(
                        text: 'Exit',
                        color: AppColors.redColor,
                        textColor: AppColors.whiteColor,
                        icon: Icons.exit_to_app,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.grayColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        BuildTabButton(
                              icon: Assets.asstes.images.svg.icWatchList.svg(),
                              text: 'Watch List',
                              color: showWatchList ? AppColors.yellowColor : AppColors.whiteColor,
                              selected: showWatchList,
                              onTap: () =>
                                  setState(() => showWatchList = true)),
                          BuildTabButton(
                              icon: Assets.asstes.images.svg.icHistory.svg(),
                              text: 'History',
                              color: !showWatchList ? AppColors.yellowColor : AppColors.whiteColor,
                              selected: !showWatchList,
                              onTap: () =>
                                  setState(() => showWatchList = false)),
                        ],
                      ),
                    ),
                    Container(
                      color: AppColors.blackColor,
                      child: currentList.isEmpty
                          ? Center(
                        child: Assets.asstes.images.png.popcorn1.image(),
                      )
                          : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: currentList.length,
                        itemBuilder: (context, index) {
                          final movie = currentList[index];
                          return Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    movie.poster,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}