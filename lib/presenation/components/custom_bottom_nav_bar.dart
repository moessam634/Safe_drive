import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app_colors.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  void navigateToPage(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onItemTapped(int index) {
    navigateToPage(index);
  }

  // final List<Widget> screenOption = [
  //   const HomeScreen(),
  //  const ProfileScreen(),
  //  const SettingsScreen(),
  // ];
  void changeItem(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: <Widget>[
          HomeScreen(navigateToPage: navigateToPage),
          ProfileScreen(navigateToPage: navigateToPage),
          SettingsScreen(navigateToPage: navigateToPage),
        ],
      ),
      // body: screenOption.elementAt(currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 55.h,
        buttonBackgroundColor: AppColors.latte1,
        color: AppColors.teel,
        backgroundColor: AppColors.latte0,
        // onTap: changeItem,
        onTap: _onItemTapped,

        items: [
          Icon(
            CupertinoIcons.home,
            color: currentIndex == 0 ? AppColors.teel : AppColors.latte1,
            size: 25.w,
          ),
          Icon(
            Icons.account_circle,
            color: currentIndex == 1 ? AppColors.teel : AppColors.latte1,
            size: 25.w,
          ),
          Icon(
            Icons.settings,
            color: currentIndex == 2 ? AppColors.teel : AppColors.latte1,
            size: 25.w,
          ),
        ],
      ),
    );
  }
}
