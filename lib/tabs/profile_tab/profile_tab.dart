import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/common/Widget/custom_main_button.dart';
import 'package:movies/providers/settings_provider.dart';
import 'package:movies/screens/update%20profile/update_profile.dart';
import 'package:movies/tabs/profile_tab/header_profile.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = '/profile_tab';
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final avatarPro = context.watch<SettingsProvider>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(flex: 2, child: HeaderProfile()),
            Expanded(
              flex: 1,
              child: Container(
                color: AppColors.grayColor,
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: CustomMainButton(
                          text: 'Edit profile', // TODO localization
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
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: CustomMainButton(
                          text: 'Exit', // TODO localization
                          color: AppColors.redColor,
                          textColor: AppColors.whiteColor,
                          icon: Icons.exit_to_app,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: AppColors.grayColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FilledButton(
                                style: FilledButton.styleFrom(backgroundColor: AppColors.grayColor),
                                onPressed: () {
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Assets.asstes.images.svg.icWatchList.svg(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Watch List', // TODO localization
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: FilledButton(
                                style: FilledButton.styleFrom(backgroundColor: AppColors.grayColor),
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    Assets.asstes.images.svg.icHistory.svg(),
                                    Text(
                                      'History', // TODO localization
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: AppColors.blackColor,
                        child: Center(
                          child: Container(
                            child: Assets.asstes.images.png.popcorn1.image(),
                            height: 130,
                            width: 130,
                          ),
                        ),
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