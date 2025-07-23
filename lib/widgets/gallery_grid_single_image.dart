import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';
import 'package:image_gallery/widgets/gallery_grid_data.dart';

class GalleryGridSingleImage extends StatefulWidget {
  final int gridIndex;
  final String assetUrl;
  final GalleryGridData galleryGridData;

  const GalleryGridSingleImage({
    super.key,
    required this.gridIndex,
    required this.assetUrl,
    required this.galleryGridData,
  });

  @override
  State<GalleryGridSingleImage> createState() => _GalleryGridSingleImageState();
}

class _GalleryGridSingleImageState extends State<GalleryGridSingleImage> {
  double deltaTravelX = 0;
  var _imageFit = BoxFit.contain;

  changeImageFit(BoxFit fit) {
    setState(() {
      _imageFit = fit;
    });
  }

  close(BuildContext context) {
    Navigator.pop(context);
  }

  onHorizontalDragUpdate(DragUpdateDetails d) {
    double deltaX = d.delta.dx;
    deltaTravelX += deltaX;
    // If accumulated deltaX reached 100+
    // This is a swipe-right
    if (deltaTravelX > 100) {
      // Check if next image exists
      if (widget.galleryGridData.checkIndex(widget.gridIndex - 1)) {
        // Get MaterialPageRoute from Grid Data
        Navigator.pushReplacement(
          context,
          widget.galleryGridData.getAltRouteForIndex(
            context,
            widget.gridIndex - 1,
            widget.gridIndex
          ),
        );
      }
    }
    // If accumulated deltaX reached 100+
    // This is a swipe-left
    else if (deltaTravelX < -100) {
      // Check if next image exists
      if (widget.galleryGridData.checkIndex(widget.gridIndex + 1)) {
        // Get MaterialPageRoute from Grid Data
        Navigator.pushReplacement(
          context,
          widget.galleryGridData.getAltRouteForIndex(
            context,
            widget.gridIndex + 1,
            widget.gridIndex
          ),
        );
      }
    }
  }

  onHorizontalDragEnd(DragEndDetails d) {
    deltaTravelX = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMush,
        actions: [
          IconButton.filled(
            onPressed: changeImageFit(BoxFit.cover),
            icon: Icon(Icons.zoom_in),
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          onHorizontalDragEnd: onHorizontalDragEnd,
          child: SizedBox.expand(
            child: Stack(
              children: [
                Container(color: Colors.red),
                OverflowBox(
                  maxWidth: MediaQuery.sizeOf(context).width * 2,
                  maxHeight: MediaQuery.sizeOf(context).height * 2,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
                    child: Image.asset(
                      widget.assetUrl,
                      height: double.maxFinite,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Center(child: Image.asset(widget.assetUrl, fit: _imageFit)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
