
import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';
import 'package:image_gallery/widgets/app_settings_controls.dart';
import 'package:rxdart/subjects.dart';

class AppSettings {

  static BehaviorSubject<int> galleryGridCrossAxisCount = BehaviorSubject.seeded(2);

  static void cycleGridSize() {
    int gridSize = galleryGridCrossAxisCount.value;
    if (gridSize < 4) {
      gridSize ++;
    } else {
      gridSize = 1;
    }
    galleryGridCrossAxisCount.add(gridSize);
  }

  static PersistentBottomSheetController? bottomSheetController;

  static void showSettings(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: false,
      context: context, 
      builder: (context) => AppSettingsControls(),
      backgroundColor: darkMush.withAlpha(128)
      );
  }

}