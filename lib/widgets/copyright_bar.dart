import 'package:flutter/material.dart';

/// A reusable copyright status bar widget that displays the VeroPulse GmbH copyright notice
class CopyrightBar extends StatelessWidget {
  final bool isDarkTheme;

  const CopyrightBar({
    super.key,
    this.isDarkTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFF1a1754),
        border: Border(
          top: BorderSide(
            color: isDarkTheme ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Text(
          '© 2025 VeroPulse GmbH',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
