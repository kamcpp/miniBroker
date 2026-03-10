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

  /// Button height - compact (34px)
  static const double buttonHeightCompact = 34.0;

  /// Button height - standard (38px)
  static const double buttonHeightStandard = 38.0;

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
  // PRE-LOGIN PAGES - Shared styling for config, role selection, login pages
  // ============================================================================

  /// Background overlay opacity on chart-background.jpg
  static const double preLoginOverlayOpacity = 0.9;

  /// Glass card background opacity
  static const double glassCardOpacity = 0.1;

  /// Glass card border color and width
  static const Color glassCardBorderColor = Colors.white;
  static const double glassCardBorderWidth = 0.4;

  /// Backdrop blur sigma for glass cards
  static const double glassBlurSigma = 2.0;

  /// Chip background opacity (broker name chip, etc.)
  static const double chipBackgroundOpacity = 0.15;

  /// Chip border opacity
  static const double chipBorderOpacity = 0.3;

  /// Chip border radius
  static const double chipBorderRadius = 20.0;

  /// Icon button background opacity (settings, back buttons)
  static const double iconButtonBackgroundOpacity = 0.1;

  /// Text field fill opacity on pre-login pages
  static const double textFieldFillOpacity = 0.9;

  /// Full-width login button height
  static const double loginButtonHeight = 50.0;

  /// Pre-login card glass decoration
  static BoxDecoration glassCardDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(glassCardOpacity),
      borderRadius: BorderRadius.circular(borderRadiusLg),
      border: Border.all(
        color: glassCardBorderColor,
        width: glassCardBorderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 0),
          spreadRadius: 3,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  /// Pre-login background (chart image + overlay)
  static Widget preLoginBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/chart-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: colorCommand.withOpacity(preLoginOverlayOpacity),
        ),
      ],
    );
  }

  /// Broker name chip widget
  static Widget brokerNameChip(String brokerName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(chipBackgroundOpacity),
        borderRadius: BorderRadius.circular(chipBorderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(chipBorderOpacity),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.business, color: Colors.white70, size: 16),
          const SizedBox(width: 6),
          Text(
            brokerName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Pre-login icon button style (back, settings)
  static ButtonStyle preLoginIconButtonStyle() {
    return IconButton.styleFrom(
      backgroundColor: Colors.white.withOpacity(iconButtonBackgroundOpacity),
      padding: const EdgeInsets.all(12),
    );
  }

  /// Pre-login primary button style (login, etc.)
  static ButtonStyle preLoginButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: colorCommand,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(textFieldBorderRadius),
      ),
      elevation: 0,
    );
  }

  /// Pre-login text field decoration
  static InputDecoration preLoginInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: textFieldFontSize),
      filled: true,
      fillColor: Colors.white.withOpacity(textFieldFillOpacity),
      contentPadding: textFieldPadding,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(textFieldBorderRadius),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(textFieldBorderRadius),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(textFieldBorderRadius),
        borderSide: const BorderSide(color: colorCommand, width: 2),
      ),
      prefixIcon: Icon(prefixIcon, color: Colors.grey, size: textFieldIconSize),
      suffixIcon: suffixIcon,
    );
  }

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
