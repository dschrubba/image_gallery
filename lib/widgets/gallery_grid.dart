import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_gallery/app_settings.dart';
import 'package:image_gallery/images_list.dart';
import 'package:image_gallery/widgets/gallery_grid_image.dart';
import 'package:image_gallery/widgets/gallery_grid_data.dart';

class GalleryGrid extends StatefulWidget {
  const GalleryGrid({super.key});

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  final List<StreamSubscription> _subscriptions = [];
  int _crossAxis = AppSettings.galleryGridCrossAxisCount.value;
  late GalleryGridData _galleryGridData;

  void setCrossAxisCount(int count) {
    log("setCrossAxisCount:$count");
    setState(() {
      _crossAxis = count;
    });
  }

  @override
  void initState() {
    super.initState();
    _galleryGridData = GalleryGridData(
      context: context,
      assetUrls: dummyImages,
      assetsPathPrefix: "assets/images/"
    );
    _subscriptions.add(AppSettings.galleryGridCrossAxisCount.listen((int value) => setCrossAxisCount(value)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: _crossAxis,
      children: [for (int index = 0; index < _galleryGridData.data.length; index++) 
        if (_galleryGridData.getImageAtOrNull(index) != null)
          GalleryGridImage(
            gridIndex: index,
            assetUrl: _galleryGridData.getImageAt(index)!.assetUrl,
            galleryGridData: _galleryGridData,
          )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var sub in _subscriptions) {
      sub.cancel();
    }
  }
}
