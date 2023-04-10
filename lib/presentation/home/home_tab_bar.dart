import 'package:fcc_final_project/presentation/movie/search_movie.dart';
import 'package:fcc_final_project/presentation/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mekari_pixel/mekari_pixel.dart';

import 'home_page.dart';

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({Key? key}) : super(key: key);

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isNeedSafeArea = MediaQuery.of(context).viewPadding.bottom > 0;
    return Scaffold(
      backgroundColor: MpColors.white,
      bottomNavigationBar: MediaQuery(
        data: const MediaQueryData(padding: EdgeInsets.only(bottom: 15)),
        child: SafeArea(
          minimum: isNeedSafeArea
              ? const EdgeInsets.only(bottom: 30)
              : EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 3.0,
                    offset: const Offset(0, -3.0))
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: MpColors.white,
              currentIndex: currentPage,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              unselectedLabelStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: MpColors.gray.shade400),
              selectedLabelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: MpColors.mekari),
              selectedItemColor: MpColors.mekari,
              onTap: ((value) {
                if (currentPage != value) {
                  setState(() {
                    currentPage = value;
                  });
                  pageController.jumpToPage(value);
                }
              }),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: const Icon(CupertinoIcons.house_alt_fill, color: MpColors.mekari)
                  ),
                  icon: Container(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Icon(CupertinoIcons.house_alt_fill, color: MpColors.gray.shade400)
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: const Icon(CupertinoIcons.search, color: MpColors.mekari)
                  ),
                  icon: Container(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Icon(CupertinoIcons.search, color: MpColors.gray.shade400)
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: const Icon(CupertinoIcons.profile_circled, color: MpColors.mekari)
                  ),
                  icon: Container(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Icon(CupertinoIcons.profile_circled, color: MpColors.gray.shade400)
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            HomePage(),
            SearchMoviePage(),
            ProfilePage(),
          ]),
    );
  }
}
