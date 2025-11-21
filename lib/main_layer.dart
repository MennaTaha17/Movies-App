import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/Tabs/Home%20tab/home_tab.dart';
import 'package:movies/Tabs/Search%20Tab/search_tab.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/tabs/profile_tab/profile_tab.dart';

import 'Tabs/browse_tab.dart';
import 'gen/assets.gen.dart';

class MainLayer extends StatefulWidget {
  static const String routeName = '/main_layer';
  const MainLayer({super.key});

  @override
  State<MainLayer> createState() => _MainLayerState();
}

class _MainLayerState extends State<MainLayer> {
  List<Widget> tabs = [
    HomeTab(),
    SearchScreen(),
    BrowseScreen(),
    ProfileTab(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.grayColor,
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Assets.asstes.images.svg.unselIcHome.svg(),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Assets.asstes.images.svg.selIcHome.svg(),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Assets.asstes.images.svg.unselIcSearch.svg(),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Assets.asstes.images.svg.selIcSearch.svg(),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Assets.asstes.images.svg.unselIcExplore.svg(),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Assets.asstes.images.svg.selIcExplore.svg(),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Assets.asstes.images.svg.unselIcProfiel.svg(),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Assets.asstes.images.svg.selIcProfile.svg(),
                ),
                label: "",
              ),
            ],
          ),
        ),
      ),
      body: tabs[currentIndex],
    );
  }
}
