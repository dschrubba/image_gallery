import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';
import 'package:image_gallery/main_events.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {

  final PageController pageController;

  const MainAppBar({super.key, required this.pageController});

  void cycleGridSize() {
    int gridSize = galleryGridCrossAxisCount.value;
    if (gridSize < 4) {
      gridSize ++;
    } else {
      gridSize = 1;
    }
    galleryGridCrossAxisCount.add(gridSize);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(onPressed: cycleGridSize, icon: Icon(Icons.grid_4x4_outlined))
      ],
      backgroundColor: mellowMush,
      title: Text("GALLERIE"),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}