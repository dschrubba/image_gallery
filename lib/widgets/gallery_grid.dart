import 'package:flutter/material.dart';
import 'package:image_gallery/images_list.dart';
import 'package:image_gallery/widgets/gallery_grid_image.dart';
import 'package:image_gallery/widgets/gallery_grid_data.dart';

class GalleryGrid extends StatefulWidget {
  const GalleryGrid({super.key});

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  GalleryGridData galleryGridData = GalleryGridData(
    assetUrls: dummyImages,
    assetsPathPrefix: "assets/images/"
    );
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 2,
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
}
