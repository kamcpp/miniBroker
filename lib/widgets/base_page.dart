import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../config/ui_constants.dart';
import '../widgets/app_header.dart';
import '../widgets/left_menu.dart';
import '../widgets/copyright_bar.dart';

/// Base page layout with header, left menu, content area, and footer
/// Provides a consistent layout structure for all main application pages
class BasePage extends StatefulWidget {
  final List<MenuItem> menuItems;
  final Widget content;
  final bool showLeftMenu;
  final bool initialMenuExpanded;

  const BasePage({
    super.key,
    required this.menuItems,
    required this.content,
    this.showLeftMenu = true,
    this.initialMenuExpanded = true,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late bool _isDarkTheme;

  @override
  void initState() {
    super.initState();
    final themeService = Provider.of<ThemeService>(context, listen: false);
    _isDarkTheme = themeService.isDarkTheme;
  }

  void _refreshTheme() {
    setState(() {
      final themeService = Provider.of<ThemeService>(context, listen: false);
      _isDarkTheme = themeService.isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/chart-background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: UIConstants.colorCommand.withOpacity(UIConstants.appOverlayOpacity),
          child: Column(
            children: [
              // Header Section
              AppHeader(
                isDarkTheme: _isDarkTheme,
                onThemeToggle: _refreshTheme,
              ),

              // Main Content Area (Left Menu + Content)
              Expanded(
                child: Row(
                  children: [
                    // Left Menu (if enabled)
                    if (widget.showLeftMenu)
                      LeftMenu(
                        menuItems: widget.menuItems,
                        isDarkTheme: _isDarkTheme,
                        initiallyExpanded: widget.initialMenuExpanded,
                      ),

                    // Main Content Area
                    Expanded(
                      child: Column(
                        children: [
                          // Content Section
                          Expanded(
                            child: widget.content,
                          ),

                          // Footer Section
                          CopyrightBar(isDarkTheme: _isDarkTheme),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}