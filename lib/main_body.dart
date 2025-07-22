import 'package:flutter/material.dart';
import 'package:image_gallery/screens/screen_about.dart';
import 'package:image_gallery/screens/screen_gallery.dart';

class MainBody extends StatelessWidget {
  final PageController pageController;
  final Function(int index) onPageChanged;

  const MainBody({super.key, required this.onPageChanged, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: onPageChanged,
      children: [
      ScreenGallery(),
      ScreenAbout()
    ],);
  }
}