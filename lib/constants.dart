import 'package:flutter/material.dart';

/// Screens wider than this use a permanent side nav and multi-column grids.
const double desktopBreakpoint = 900;

bool isWideScreen(BuildContext context) {
  return MediaQuery.sizeOf(context).width > desktopBreakpoint;
}

/// 1 column on mobile, 2 on tablet-wide, 3 on very wide screens.
int gridColumnCount(double width) {
  if (width > 1200) return 3;
  if (width > desktopBreakpoint) return 2;
  return 1;
}

const Color moodlePurple = Color(0xFF5D2D5F);
const Color moodleDarkPurple = Color(0xFF4A204C);
const Color moodleBg = Color(0xFFF2F2F2);
const Color moodleBlue = Color(0xFF0075FF);
const Color moodleGrayBg = Color(0xFFE9ECEF);
const Color moodleSecondary = Color(0xFF4A4A4A);
const Color moodleSurface = Color(0xFFF8F9FA);
const Color moodleWhite = Colors.white;
const Color moodleTextDark = Colors.black87;
const Color moodleTextMuted = Colors.black54;
const Color moodleBorder = Color(0xFFE0E0E0);
