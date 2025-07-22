import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {

  final PageController pageController;

  const MainAppBar({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mellowMush,
      title: Text("GALLERIE"),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}