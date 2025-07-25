import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_gallery/app_settings.dart';
import 'package:image_gallery/app_themes.dart';

class AppSettingsControls extends StatefulWidget {
  const AppSettingsControls({super.key});

  @override
  State<AppSettingsControls> createState() => _AppSettingsControlsState();
}

class _AppSettingsControlsState extends State<AppSettingsControls> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(child:  BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 32,
        sigmaY: 32
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: 
              Icon(Icons.drag_handle_rounded, size: 32, color: lightMush,)),
              Text("Grid Size", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: lightMush)),
              Slider(
                padding: EdgeInsets.all(0),
                min: 1,
                max: 4,
                thumbColor: lightMush,
                activeColor: lightMush,
                inactiveColor: mellowMush,
                value: AppSettings.galleryGridCrossAxisCount.value.toDouble(),
                onChanged: (double value) => setState(() {
                  AppSettings.galleryGridCrossAxisCount.add(value.toInt());
                }),
              ),
              SizedBox(
                height: 48,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
