import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';
import 'package:image_gallery/main_app_bar.dart';
import 'package:image_gallery/main_body.dart';
import 'package:image_gallery/main_navbar.dart';

void main() {
  runApp(AppHome());
}

class AppHome extends StatelessWidget {
  AppHome({super.key});

  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey navBarKey = GlobalKey<MainNavbarState>();

  void changePage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLAXCOM',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      home: Scaffold(
        appBar: MainAppBar(
          pageController: _pageController,
        ),
        body: MainBody(
          pageController: _pageController,
          onPageChanged: (index) {
            if (navBarKey.currentState is MainNavbarState) {
              (navBarKey.currentState as MainNavbarState).updateCurrentIndex(index);
            }
          },
        ),
        bottomNavigationBar: MainNavbar(
          onDestinationSelected: changePage,
          key: navBarKey,
          pageController: _pageController
        ),
      )
    );
  }
}