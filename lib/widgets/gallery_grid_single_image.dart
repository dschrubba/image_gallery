import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';
import 'package:image_gallery/widgets/gallery_grid_data.dart';
import 'package:photo_view/photo_view.dart';

class GalleryGridSingleImage extends StatefulWidget {
  final String assetUrl;
  final GalleryGridData galleryGridData;

  const GalleryGridSingleImage({
    super.key,
    required this.assetUrl,
    required this.galleryGridData,
  });

  @override
  State<GalleryGridSingleImage> createState() => _GalleryGridSingleImageState();
}

class _GalleryGridSingleImageState extends State<GalleryGridSingleImage> {
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

  void setAppBarTitle(int index) {
    setState(() {
      _appBarTitle =
          widget.galleryGridData.getImageAt(index)?.assetUrl.toString() ?? "";
    });
  }

  onPageChanged(int index) {
    setAppBarTitle(index);
  }

  bool _infoIconVisible = false;
  void onTap() {
    // Toggle info icon visibility
    setState(() {
      _infoIconVisible = !_infoIconVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    setAppBarTitle(widget.galleryGridData.getIndexByUrl(widget.assetUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMush,
        title: Text(_appBarTitle, overflow: TextOverflow.ellipsis),
        actions: [
          /*IconButton.filled(
            onPressed: toggleImageFit,
            icon: Icon(Icons.fullscreen),
          ),*/
        ],
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: PageController(
            initialPage: widget.galleryGridData.getIndexByUrl(widget.assetUrl)
          ),
          onPageChanged: onPageChanged,
          itemCount: widget.galleryGridData.data.length,
          itemBuilder: (context, index) => SizedBox.expand(
            child: GestureDetector(
              onTap: onTap,
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
                        backgroundDecoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        imageProvider: Image.asset(
                          widget.galleryGridData.getImageAt(index)!.assetUrl,
                        ).image,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.all(8),
                          child: IconButton(
                            iconSize: 32,
                            icon: Icon(Icons.info_outline),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return widget.galleryGridData
                                      .getImageAt(index)!
                                      .bottomSheet;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
