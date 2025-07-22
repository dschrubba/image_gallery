import 'package:flutter/material.dart';

const Color darkMush = Color(0xFF081C15);
const Color mellowMush = Color(0xFF2D6A4F);
const Color lightMush = Color(0xFFD8F3DC);
const Color accentMush = Color(0xFF52B788);

class AppThemes {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.light().copyWith(
      primary: darkMush
    ),
  );
  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.light().copyWith(
      primary: darkMush,
      onPrimary: lightMush,
      inversePrimary: accentMush,
      secondary: darkMush,
      onSecondary: lightMush,
      surface: darkMush,
      onSurface: lightMush,
      inverseSurface: lightMush,
      onInverseSurface: darkMush,
      primaryContainer: accentMush,
      onPrimaryContainer: lightMush,
      secondaryContainer: accentMush, // Navbar selection color
      onSecondaryContainer: lightMush,
      surfaceContainer: darkMush, // Navbar
      onSurfaceVariant: lightMush, // Text on Navbar
    ),
  );
}
