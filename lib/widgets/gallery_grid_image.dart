import 'package:flutter/material.dart';
import 'package:image_gallery/widgets/gallery_grid_single_image.dart';

class GalleryGridImage extends StatefulWidget {
  final String assetUrl;
  const GalleryGridImage({super.key, required this.assetUrl});

  @override
  State<GalleryGridImage> createState() => _GalleryGridImageState();
}

void onImageTap(BuildContext context, String assetUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => GalleryGridSingleImage(assetUrl: assetUrl)),
  );
}

class _GalleryGridImageState extends State<GalleryGridImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(16),
      child: GestureDetector(
        onTap: () => onImageTap(context, widget.assetUrl),
        child: Image.asset(widget.assetUrl, fit: BoxFit.cover),
      ),
    );
  }
}
