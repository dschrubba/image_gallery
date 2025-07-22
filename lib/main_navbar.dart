import 'package:flutter/material.dart';

class MainNavbar extends StatefulWidget {
  final PageController pageController;
  final Function(int index) onDestinationSelected;
  const MainNavbar({super.key, required this.pageController, required this.onDestinationSelected});

  @override
  State<MainNavbar> createState() => MainNavbarState();
}

class MainNavbarState extends State<MainNavbar> {
  int _currentIndex = 0;
  void updateCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: widget.onDestinationSelected,
      selectedIndex: _currentIndex,
      destinations: [
      NavigationDestination(icon: Icon(Icons.image), label: "Gallery"),
      NavigationDestination(icon: Icon(Icons.info), label: "About")
    ]);
  }
}