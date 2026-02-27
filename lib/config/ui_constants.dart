/// Centralized UI/UX constants for compact, information-dense broker app design
/// This file controls spacing, typography, and layout density across the entire app

import 'package:flutter/material.dart';

class UIConstants {
  // ============================================================================
  // SPACING - Compact spacing for information density
  // ============================================================================

  /// Micro spacing for very tight layouts (2px)
  static const double spacingMicro = 2.0;

  /// Extra small spacing for compact elements (4px)
  static const double spacingXs = 4.0;

  /// Small spacing for list items, cards (6px)
  static const double spacingSm = 6.0;

  /// Medium spacing - default for most elements (8px)
  static const double spacingMd = 8.0;

  /// Large spacing for major sections (12px)
  static const double spacingLg = 12.0;

  /// Extra large spacing for page-level separation (16px)
  static const double spacingXl = 16.0;

  // ============================================================================
  // PADDING - Compact padding for controls and containers
  // ============================================================================

  /// Minimal padding for dense data tables (4px all around)
  static const EdgeInsets paddingMinimal = EdgeInsets.all(4.0);

  /// Compact padding for buttons, inputs (6px vertical, 10px horizontal)
  static const EdgeInsets paddingCompact = EdgeInsets.symmetric(
    vertical: 6.0,
    horizontal: 10.0,
  );

  /// Standard padding for cards, containers (8px all around)
  static const EdgeInsets paddingStandard = EdgeInsets.all(10.0);

  /// Comfortable padding for dialogs, pages (12px all around)
  static const EdgeInsets paddingComfortable = EdgeInsets.all(12.0);

  /// Small padding value (6px)
  static const double paddingSm = 6.0;

  /// Medium padding value (12px)
  static const double paddingMd = 12.0;

  // ============================================================================
  // TEXT FIELD SETTINGS - Compact input field styling
  // ============================================================================

  /// Text field content padding for compact height (login/signup full-height fields)
  static const EdgeInsets textFieldPadding = EdgeInsets.symmetric(
    horizontal: 8.0,
    vertical: 15.0,
  );

  /// Standard content padding for inline text fields and dropdowns
  static const EdgeInsets textFieldContentPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 8.0,
  );

  /// Text field font size
  static const double textFieldFontSize = fontSizeBody;

  /// Text field border radius
  static const double textFieldBorderRadius = borderRadiusSm;

  /// Text field icon size
  static const double textFieldIconSize = 15.0;

  // ============================================================================
  // TYPOGRAPHY - Compact, readable font sizes
  // ============================================================================

  /// Extra small text - for labels, hints (10px)
  static const double fontSizeXs = 10.0;

  /// Small text - for secondary info, captions (11px)
  static const double fontSizeSm = 11.0;

  /// Body text - default for most content (12px)
  static const double fontSizeBody = 12.0;

  /// Medium text - for emphasis, subheadings (13px)
  static const double fontSizeMd = 13.0;

  /// Large text - for headings, titles (14px)
  static const double fontSizeLg = 14.0;

  /// Extra large - for page headers (16px)
  static const double fontSizeXl = 16.0;

  /// Display - for major headers (18px)
  static const double fontSizeDisplay = 18.0;

  // ============================================================================
  // FONT WEIGHTS - Normal weight by default, bold for emphasis only
  // ============================================================================

  /// Normal weight for all body text
  static const FontWeight fontWeightNormal = FontWeight.w400;

  /// Medium weight for subtle emphasis
  static const FontWeight fontWeightMedium = FontWeight.w500;

  /// Bold weight for headers and important info only
  static const FontWeight fontWeightBold = FontWeight.w600;

  // ============================================================================
  // COMMON TEXT STYLES - Pre-configured for consistency
  // ============================================================================

  /// Caption style - for labels, hints
  static const TextStyle textCaption = TextStyle(
    fontSize: fontSizeXs,
    fontWeight: fontWeightNormal,
    height: 1.2,
  );

  /// Body style - default text
  static const TextStyle textBody = TextStyle(
    fontSize: fontSizeBody,
    fontWeight: fontWeightNormal,
    height: 1.3,
  );

  /// Body emphasis - slightly larger, medium weight
  static const TextStyle textBodyEmphasis = TextStyle(
    fontSize: fontSizeMd,
    fontWeight: fontWeightMedium,
    height: 1.3,
  );

  /// Heading style - for section headers
  static const TextStyle textHeading = TextStyle(
    fontSize: fontSizeLg,
    fontWeight: fontWeightMedium,
    height: 1.4,
  );

  /// Title style - for page titles
  static const TextStyle textTitle = TextStyle(
    fontSize: fontSizeXl,
    fontWeight: fontWeightBold,
    height: 1.4,
  );

  // ============================================================================
  // COMPONENT SIZES - Compact dimensions
  // ============================================================================

  /// Button height - compact (28px)
  static const double buttonHeightCompact = 28.0;

  /// Button height - standard (32px)
  static const double buttonHeightStandard = 32.0;

  /// Input field height - compact (32px)
  static const double inputHeightCompact = 32.0;

  /// Icon size - small (14px)
  static const double iconSizeSm = 14.0;

  /// Icon size - standard (16px)
  static const double iconSizeMd = 16.0;

  /// Icon size - large (20px)
  static const double iconSizeLg = 20.0;

  // ============================================================================
  // COLORS - Standard colors for consistency across the app
  // ============================================================================

  /// Soft green for OK, accept, buy, deposit, confirm buttons
  static const Color colorAccept = Color(0xFF4CAF50);

  /// Light red for cancel, sell, withdraw, reject, delete buttons
  static const Color colorReject = Color(0xFFEF5350);

  /// Dark blueish for neutral command buttons (login, fetch, apply, save)
  static const Color colorCommand = Color(0xFF1a1754);

  /// Standard blue for info, links
  static const Color colorPrimary = Color(0xFF2196F3);

  /// Standard orange for warning
  static const Color colorWarning = Color(0xFFFF9800);

  /// Dark fill color for dropdowns/fields in dark theme
  static const Color colorDarkFill = Color(0xFF2d2d2d);

  // ============================================================================
  // BORDER RADIUS - Minimal rounding for sharp, professional look
  // ============================================================================

  /// Small radius for compact elements (2px)
  static const double borderRadiusSm = 2.0;

  /// Medium radius for cards, buttons (3px)
  static const double borderRadiusMd = 3.0;

  /// Large radius for dialogs, major containers (4px)
  static const double borderRadiusLg = 4.0;

  // ============================================================================
  // LIST/TABLE SETTINGS - Dense data display
  // ============================================================================

  /// List item height - compact (36px)
  static const double listItemHeightCompact = 36.0;

  /// List item height - standard (40px)
  static const double listItemHeightStandard = 40.0;

  /// Divider thickness (0.5px)
  static const double dividerThickness = 0.5;

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Get text style with custom color
  static TextStyle textStyleWithColor(TextStyle baseStyle, Color color) {
    return baseStyle.copyWith(color: color);
  }

  /// Get compact padding for horizontal lists
  static EdgeInsets paddingHorizontal(double value) {
    return EdgeInsets.symmetric(horizontal: value);
  }

  /// Get compact padding for vertical lists
  static EdgeInsets paddingVertical(double value) {
    return EdgeInsets.symmetric(vertical: value);
  }

  /// Standard button style with consistent shape, height, and color
  static ButtonStyle buttonStyle(Color backgroundColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusSm),
      ),
      minimumSize: const Size(0, buttonHeightStandard),
    );
  }
}
