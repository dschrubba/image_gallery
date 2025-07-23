import 'package:flutter/material.dart';
import 'package:image_gallery/widgets/gallery_grid_data.dart';

class GalleryGridImage extends StatefulWidget {
  final int     gridIndex;
  final String  assetUrl;
  final GalleryGridData galleryGridData;
  const GalleryGridImage({super.key, required this.gridIndex, required this.assetUrl, required this.galleryGridData});

  @override
  State<GalleryGridImage> createState() => _GalleryGridImageState();
}

void onImageTap(BuildContext context, int targetIndex, GalleryGridData galleryGridData) {
  Navigator.push(
    context,
    galleryGridData.getRouteForIndex(context, targetIndex)
  );
}

class _GalleryGridImageState extends State<GalleryGridImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(16),
      child: GestureDetector(
        onTap: () => onImageTap(
          context,
          widget.gridIndex,
          widget.galleryGridData
          ),
        child: Image.asset(
          widget.assetUrl, 
          fit: BoxFit.cover),
      ),
    );
  }
}
