import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';

class GalleryGridSingleImage extends StatefulWidget {
  final String assetUrl;
  const GalleryGridSingleImage({super.key, required this.assetUrl});

  @override
  State<GalleryGridSingleImage> createState() => _GalleryGridSingleImageState();
}

class _GalleryGridSingleImageState extends State<GalleryGridSingleImage> {

  var _imageFit = BoxFit.contain;

  changeImageFit(BoxFit fit) {
    setState(() {
      _imageFit = fit;
    });
  }

  close(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMush,
        actions: [
          IconButton.filled(onPressed: changeImageFit(BoxFit.cover), icon: Icon(Icons.zoom_in)),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
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
                Center(child: Image.asset(widget.assetUrl, fit: _imageFit,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
