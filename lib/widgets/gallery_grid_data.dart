import 'package:flutter/material.dart';
import 'package:image_gallery/widgets/gallery_grid_single_image.dart';

class GalleryGridData{

  final String assetsPathPrefix;
  final List<GalleryGridImageData> _galleryGridImageData = [];
  List<GalleryGridImageData> get data  => _galleryGridImageData;

  GalleryGridData({required List<String> assetUrls, required this.assetsPathPrefix}) {
    for (int i = 0; i < assetUrls.length; i++) {
      _galleryGridImageData.add(
        GalleryGridImageData(
          index: i,
          assetUrl: "$assetsPathPrefix${assetUrls[i]}"
        )
      );
    }
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
  MaterialPageRoute getRouteForIndex(BuildContext context, int index) {
    return MaterialPageRoute(builder: (context) => GalleryGridSingleImage(
      gridIndex: index,
      assetUrl: _galleryGridImageData[index].assetUrl,
      galleryGridData: this,
      )
    );
  }
  bool pushRouteForIndex(BuildContext context, int index) {
    bool exists = checkIndex(index);
    if (exists) {
      MaterialPageRoute route = getRouteForIndex(context, index);
      Navigator.of(context).push(route);
    }
    return exists;
  }
}

@immutable
class GalleryGridImageData{
  final int index;
  final String assetUrl;
  const GalleryGridImageData({required this.index, required this.assetUrl});
}