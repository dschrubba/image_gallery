import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';
import 'package:image_gallery/widgets/elastic_pull_wrapper.dart';
import 'package:image_gallery/widgets/gallery_grid_data.dart';
import 'package:photo_view/photo_view.dart';

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
  final _photoViewController = PhotoViewController();
  final List<StreamSubscription> _subscriptions = [];
  var _allowPageScrolling = true;
  var _pageViewScrollPhysics = ScrollPhysics();
  var _appBarTitle = "";

  toggleImageFit() {}

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
      _appBarTitle =
          widget.galleryGridData.getImageAt(index)?.assetUrl.toString() ?? "";
    });
  }

  addSubscription(StreamSubscription subscription) {
    if (_subscriptions.contains(subscription)) {
      int idx = _subscriptions.indexOf(subscription);
      _subscriptions[idx].cancel();
      _subscriptions.remove(subscription);
    }
    _subscriptions.add(subscription);
  }

  bool allowPageScrolling(double scale) {
    log("_currentScale: $scale");
    bool allow = scale == 1.0;
    if (_allowPageScrolling != allow) {
      _allowPageScrolling = allow;
      setState(() {
        if (allow) {
          _pageViewScrollPhysics = PageScrollPhysics();
        } else {
          _pageViewScrollPhysics = NeverScrollableScrollPhysics();
        }
      });
    }
    return allow;
  }

  @override
  Widget build(BuildContext context) {
    addSubscription(
      _photoViewController.outputStateStream.listen((
        PhotoViewControllerValue value,
      ) {
        allowPageScrolling(value.scale ?? 1.0);
      }),
    );
    allowPageScrolling(_photoViewController.scale ?? 1.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMush,
        title: Text(_appBarTitle, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton.filled(
            onPressed: toggleImageFit,
            icon: Icon(Icons.fullscreen),
          ),
        ],
      ),
      body: SafeArea(
        child: PageView.builder(
          physics: _pageViewScrollPhysics,
          onPageChanged: onPageChanged,
          itemCount: widget.galleryGridData.data.length,
          itemBuilder: (context, index) => SizedBox.expand(
            child: ClipRect(
              child: Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 64,
                      sigmaY: 64,
                      tileMode: TileMode.mirror,
                    ),
                    child: Image.asset(
                      widget.galleryGridData.getImageAt(index)!.assetUrl,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.multiply,
                      color: darkMush.withAlpha(128),
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

  @override
  void dispose() {
    super.dispose();
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }
}
