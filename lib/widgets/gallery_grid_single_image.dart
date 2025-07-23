import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';
import 'package:image_gallery/widgets/elastic_pull_wrapper.dart';
import 'package:image_gallery/widgets/gallery_grid_data.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
  var _photoViewController = PhotoViewController();
  var _imageFit = BoxFit.contain;
  var _appBarTitle = "";

  toggleImageFit() {

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

  onPanUpdate(DragUpdateDetails d) {
    log(d.globalPosition.distance.toString());
  }

  onPageChanged(int index) {
    setState(() {
      _appBarTitle = widget.galleryGridData.getImageAt(index)?.assetUrl.toString() ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMush,
        title: Text(
          _appBarTitle,
          overflow: TextOverflow.ellipsis),
        actions: [
          IconButton.filled(
            onPressed: toggleImageFit,
            icon: Icon(Icons.fullscreen),
          ),
        ],
      ),
      body: SafeArea(
        child: PageView.builder(
          onPageChanged: onPageChanged,
          itemCount: widget.galleryGridData.data.length,
          itemBuilder: (context, index) => SizedBox.expand(
            child: ClipRect(
              child: Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 64, sigmaY: 64, tileMode: TileMode.mirror),
                    child: Image.asset(
                      widget.galleryGridData.getImageAt(index)!.assetUrl,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.multiply,
                      color: darkMush.withAlpha(128)
                    ),
                  ),
                  Container(
                    alignment: AlignmentGeometry.directional(0, 0),
                    child: PhotoView(
                      minScale: 1.0,
                      maxScale: 4.0,
                      controller: _photoViewController,
                      backgroundDecoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      imageProvider: Image.asset(
                        widget.galleryGridData.getImageAt(index)!.assetUrl,
                      ).image,
                    ),
                  ),
                  /*
              ElasticPullWrapper(
                maxOffset: 100,
                deltaFactor: 0.2,
                threshold: 15,
                onThresholdExceeded: onThresholdExceeded,
                child: Container(
                  alignment: AlignmentGeometry.directional(0, 0),
                    child: Image.asset(
                      widget.assetUrl,
                      height: double.maxFinite,
                      fit: _imageFit,
                    ),
                ),
              ),
              */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
