import 'package:flutter/material.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    const double height = 120;
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: SizedBox(
            height: height,
            width: double.maxFinite,
            child: Center(
              child: CircleAvatar(
                radius: height / 2,
                foregroundImage: Image.asset("assets/images/dummy_avatar.png").image,
              )
            ),
          ),
        ),
        Text(
          "Sharky Sharkson",
          style: Theme.of(context).textTheme.headlineMedium,
          ),
        Text(
          "The electrical ocean's finest UX/UI",
          style: Theme.of(context).textTheme.bodyLarge,
          ),
      ],
    );
  }
}
