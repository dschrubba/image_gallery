import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_gallery/images_list.dart';
import 'package:image_gallery/main_events.dart';
import 'package:image_gallery/widgets/gallery_grid_image.dart';
import 'package:image_gallery/widgets/gallery_grid_data.dart';

class GalleryGrid extends StatefulWidget {
  const GalleryGrid({super.key});

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  final List<StreamSubscription> _subscriptions = [];
  int _crossAxis = 2;
  GalleryGridData galleryGridData = GalleryGridData(
    assetUrls: dummyImages,
    assetsPathPrefix: "assets/images/"
    );

  void setCrossAxisCount(int count) {
    log("setCrossAxisCount:$count");
    setState(() {
      _crossAxis = count;
    });
  }

  @override
  void initState() {
    super.initState();
    _subscriptions.add(galleryGridCrossAxisCount.listen((int value) => setCrossAxisCount(value)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: _crossAxis,
      children: [for (int index = 0; index < galleryGridData.data.length; index++) 
        if (galleryGridData.getImageAtOrNull(index) != null)
          GalleryGridImage(
            gridIndex: index,
            assetUrl: galleryGridData.getImageAt(index)!.assetUrl,
            galleryGridData: galleryGridData,
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
