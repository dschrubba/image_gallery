import 'package:flutter/material.dart';
import 'package:image_gallery/images_list.dart';
import 'package:image_gallery/widgets/gallery_grid_image.dart';

class GalleryGrid extends StatefulWidget {
  const GalleryGrid({super.key});

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 2,
      children: [for (String imageUrl in dummyImages) 
        GalleryGridImage(assetUrl: "assets/images/$imageUrl"),
      ],
    );
  }
}
