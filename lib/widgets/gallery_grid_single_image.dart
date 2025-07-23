import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';
import 'package:image_gallery/widgets/elastic_pull_wrapper.dart';
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
  double deltaTravelY = 0;
  var _imageFit = BoxFit.contain;

  changeImageFit(BoxFit fit) {
    setState(() {
      _imageFit = fit;
    });
  }

  close(BuildContext context) {
    Navigator.pop(context);
  }

  void swipeRanged(int index, int range) {
    bool exists = widget.galleryGridData.checkIndex(index + range);
    if (exists) {
      Navigator.pushReplacement(
        context,
        widget.galleryGridData.getAltRouteForIndex(
          context,
          index + range,
          index,
        ),
      );
    }
  }

  onPulledUp(BuildContext context) {}

  onPulledDown(BuildContext context) {
    Navigator.of(context).pop();
  }

  onPulledLeft(BuildContext context) {
    swipeRanged(widget.gridIndex, 1);
  }

  onPulledRight(BuildContext context) {
    swipeRanged(widget.gridIndex, -1);
  }

  onThresholdExceeded(Direction direction, BuildContext context) {
    switch (direction) {
      case Direction.up:
        onPulledUp(context);
      case Direction.down:
        onPulledDown(context);
      case Direction.left:
        onPulledLeft(context);
      case Direction.right:
        onPulledRight(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMush,
        title: Text(widget.assetUrl, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton.filled(
            onPressed: changeImageFit(BoxFit.cover),
            icon: Icon(Icons.zoom_in),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: ElasticPullWrapper(
            maxOffset: 100,
            deltaFactor: 0.2,
            threshold: 30,
            onThresholdExceeded: onThresholdExceeded,
            child: Stack(
              children: [
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
                Center(
                  child: Image.asset(
                    widget.assetUrl,
                    fit: _imageFit,
                    alignment: AlignmentGeometry.xy(-1.0, 0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
