import 'package:flutter/material.dart';
import 'package:image_gallery/widgets/gallery_grid.dart';

class ScreenGallery extends StatefulWidget {
  const ScreenGallery({super.key});

  @override
  State<ScreenGallery> createState() => _ScreenGalleryState();
}

class _ScreenGalleryState extends State<ScreenGallery> {
  @override
  Widget build(BuildContext context) {
    return const GalleryGrid();
    }
    
  }
