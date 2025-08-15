import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double _mobileBreakpoint = 768;
  static const double _tabletBreakpoint = 1024;

  /// Check if current device is mobile (width < 768)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < _mobileBreakpoint;
  }

  /// Check if current device is tablet (width >= 768 && width < 1024)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _mobileBreakpoint && width < _tabletBreakpoint;
  }

  /// Check if current device is desktop (width >= 1024)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= _tabletBreakpoint;
  }

  /// Get responsive padding based on device type
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  /// Get responsive card padding
  static EdgeInsets getCardPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16.0);
    } else {
      return const EdgeInsets.all(24.0);
    }
  }

  /// Get responsive grid cross axis count
  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) {
      return 2;
    } else if (isTablet(context)) {
      return 3;
    } else {
      return 4;
    }
  }

  /// Get responsive font size for titles
  static double getTitleFontSize(BuildContext context) {
    if (isMobile(context)) {
      return 18.0;
    } else if (isTablet(context)) {
      return 22.0;
    } else {
      return 24.0;
    }
  }

  /// Get responsive font size for subtitles
  static double getSubtitleFontSize(BuildContext context) {
    if (isMobile(context)) {
      return 16.0;
    } else if (isTablet(context)) {
      return 18.0;
    } else {
      return 20.0;
    }
  }

  /// Get responsive font size for body text
  static double getBodyFontSize(BuildContext context) {
    if (isMobile(context)) {
      return 14.0;
    } else if (isTablet(context)) {
      return 16.0;
    } else {
      return 18.0;
    }
  }

  /// Get responsive spacing
  static double getSpacing(BuildContext context, {double multiplier = 1.0}) {
    if (isMobile(context)) {
      return 16.0 * multiplier;
    } else if (isTablet(context)) {
      return 20.0 * multiplier;
    } else {
      return 24.0 * multiplier;
    }
  }

  /// Get responsive icon size
  static double getIconSize(BuildContext context) {
    if (isMobile(context)) {
      return 32.0;
    } else if (isTablet(context)) {
      return 40.0;
    } else {
      return 48.0;
    }
  }

  /// Get responsive avatar radius
  static double getAvatarRadius(BuildContext context) {
    if (isMobile(context)) {
      return 30.0;
    } else if (isTablet(context)) {
      return 40.0;
    } else {
      return 50.0;
    }
  }

  /// Get responsive dialog width
  static double? getDialogWidth(BuildContext context) {
    if (isMobile(context)) {
      return null; // Use default
    } else if (isTablet(context)) {
      return 400.0;
    } else {
      return 500.0;
    }
  }

  /// Get responsive form field height
  static double getFormFieldHeight(BuildContext context) {
    if (isMobile(context)) {
      return 56.0;
    } else {
      return 64.0;
    }
  }

  /// Get responsive button height
  static double getButtonHeight(BuildContext context) {
    if (isMobile(context)) {
      return 48.0;
    } else if (isTablet(context)) {
      return 56.0;
    } else {
      return 64.0;
    }
  }

  /// Get responsive content max width (for centering content on large screens)
  static double getContentMaxWidth(BuildContext context) {
    if (isMobile(context)) {
      return double.infinity;
    } else if (isTablet(context)) {
      return 600.0;
    } else {
      return 800.0;
    }
  }

  /// Widget builder for responsive layouts
  static Widget responsive({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// Get responsive layout based on orientation and device type
  static Widget adaptiveLayout({
    required BuildContext context,
    required Widget child,
    bool centerContent = false,
  }) {
    final maxWidth = getContentMaxWidth(context);
    final padding = getResponsivePadding(context);

    if (centerContent && !isMobile(context)) {
      return Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: padding,
          child: child,
        ),
      );
    }

    return Padding(
      padding: padding,
      child: child,
    );
  }
}
