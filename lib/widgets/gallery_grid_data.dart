import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:image_gallery/widgets/gallery_bottom_sheet.dart';
import 'package:image_gallery/widgets/gallery_grid_single_image.dart';

class GalleryGridData{
  final BuildContext context;
  final String assetsPathPrefix;
  final List<GalleryGridImageData> _galleryGridImageData = [];
  List<GalleryGridImageData> get data  => _galleryGridImageData;
  GalleryGridData({required this.context, required List<String> assetUrls, required this.assetsPathPrefix}) {
    for (int i = 0; i < assetUrls.length; i++) {
      _galleryGridImageData.add(
        GalleryGridImageData(
          index: i,
          assetUrl: "$assetsPathPrefix${assetUrls[i]}",
          bottomSheet: GalleryBottomSheet(
            header: lorem(words: 2, paragraphs: 1),
            body: lorem(words: 100, paragraphs: 2),
          ),
        )
      );
    }
  }
  int getIndex(GalleryGridImageData galleryGridImageData) {
    return _galleryGridImageData.indexWhere((GalleryGridImageData data) => data.assetUrl == galleryGridImageData.assetUrl);
  }
  int getIndexByUrl(String assetUrl) {
    return _galleryGridImageData.indexWhere((GalleryGridImageData data) => data.assetUrl == assetUrl);
  }
  bool checkIndex(int index) {
    return (index >= 0) && (index < _galleryGridImageData.length);
  }
  GalleryGridImageData? getImageAt(int index) {
    return _galleryGridImageData[index];
  }
  GalleryGridImageData? getImageAtOrNull(int index) {
    return _galleryGridImageData.elementAtOrNull(index);
  }
  GalleryGridImageData? getNextOrNull(GalleryGridImageData gridImageData) {
    if((gridImageData.index + 1) < _galleryGridImageData.length) {
      return _galleryGridImageData[gridImageData.index + 1];
    }
    return null;
  }
  GalleryGridImageData? getPrevOrNull(GalleryGridImageData gridImageData) {
    if((gridImageData.index - 1) >= 0) {
      return _galleryGridImageData[gridImageData.index - 1];
    }
    return null;
  }
  Route getAltRouteForIndex(BuildContext context, int index, int prevIndex) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => GalleryGridSingleImage(
        assetUrl: _galleryGridImageData[index].assetUrl,
        galleryGridData: this,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin = Offset((prevIndex > index) ? -1.0 : 1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    });
  }
  MaterialPageRoute<GalleryGridSingleImage> getRouteForIndex(BuildContext context, int index) {
    return MaterialPageRoute<GalleryGridSingleImage>(
      builder: (context) => GalleryGridSingleImage(
        assetUrl: _galleryGridImageData[index].assetUrl,
        galleryGridData: this,
        )
    );
  }
  bool pushRouteForIndex(BuildContext context, int index) {
    bool exists = checkIndex(index);
    if (exists) {
      MaterialPageRoute<GalleryGridSingleImage> route = getRouteForIndex(context, index);
      Navigator.of(context).push(route);
    }
    return exists;
  }
}

@immutable
class GalleryGridImageData{
  final int index;
  final String assetUrl;
  final Widget bottomSheet;
  const GalleryGridImageData({required this.index, required this.assetUrl, required this.bottomSheet});
}