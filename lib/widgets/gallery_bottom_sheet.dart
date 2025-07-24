import 'package:flutter/material.dart';
import 'package:image_gallery/app_themes.dart';

class GalleryBottomSheet extends StatelessWidget {
  final String header;
  final String body;
  const GalleryBottomSheet({
    super.key,
    required this.body,
    required this.header,
  });
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.onInverseSurface;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              spacing: 16,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: darkMush.withAlpha(128),
                      width: 2
                    )
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    foregroundImage: Image.asset(
                      "assets/images/dummy_avatar.png",
                    ).image,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      header,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.copyWith(color: darkMush),
                    ),
                    Text(
                      "by Sharky Sharkson",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ],
            ),
            Text(body, style: TextStyle(color: textColor)),
          ],
        ),
      ),
    );
  }
}
