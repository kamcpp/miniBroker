import 'dart:io';
import 'package:flutter/material.dart';
import '../config/ui_constants.dart';

/// Menu item data model
class MenuItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const MenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });
}

/// Reusable foldable left menu component
/// Can be collapsed to show only icons or expanded to show labels
class LeftMenu extends StatefulWidget {
  final List<MenuItem> menuItems;
  final bool isDarkTheme;
  final bool initiallyExpanded;

  const LeftMenu({
    super.key,
    required this.menuItems,
    required this.isDarkTheme,
    this.initiallyExpanded = true,
  });

  @override
  State<LeftMenu> createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  static const double _collapsedWidth = 60.0;
  static const double _expandedWidth = 200.0;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Animation goes from collapsed to expanded
    _widthAnimation = Tween<double>(
      begin: _collapsedWidth,
      end: _expandedWidth,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Set initial state
    if (widget.initiallyExpanded) {
      _animationController.value = 1.0; // Fully expanded
    } else {
      _animationController.value = 0.0; // Fully collapsed
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return Container(
          width: _widthAnimation.value,
          decoration: BoxDecoration(
            color: UIConstants.menuBackground(widget.isDarkTheme),
            border: Border(
              right: BorderSide(
                color: UIConstants.borderColor(widget.isDarkTheme),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              // Toggle button
              _buildToggleButton(),

              const SizedBox(height: UIConstants.spacingMd),

              // Menu items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: UIConstants.paddingSm),
                  children: widget.menuItems.map(_buildMenuItem).toList(),
                ),
              ),

              const SizedBox(height: UIConstants.paddingSm),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleButton() {
    return InkWell(
      onTap: _toggleMenu,
      child: Container(
        padding: const EdgeInsets.all(UIConstants.paddingMd),
        child: Row(
          mainAxisAlignment: _isExpanded ? MainAxisAlignment.end : MainAxisAlignment.center,
          children: [
            Icon(
              _isExpanded ? Icons.chevron_left : Icons.chevron_right,
              color: UIConstants.textPrimary(widget.isDarkTheme),
            ),
          ],
        ),
      ),
    );
  }

  void _launchNewInstance() {
    final executable = Platform.resolvedExecutable;
    Process.start(executable, [], mode: ProcessStartMode.detached);
  }

  Widget _buildNewInstanceButton() {
    final color = UIConstants.textPrimary(widget.isDarkTheme);

    return Tooltip(
      message: _isExpanded ? '' : 'New Instance',
      child: InkWell(
        onTap: _launchNewInstance,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: UIConstants.paddingSm,
            vertical: 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.paddingMd,
            vertical: UIConstants.paddingMd,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: UIConstants.borderColor(widget.isDarkTheme),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.open_in_new,
                color: color,
                size: 22,
              ),
              if (_isExpanded) ...[
                const SizedBox(width: UIConstants.spacingMd),
                Expanded(
                  child: Text(
                    'New Instance',
                    style: TextStyle(
                      color: color,
                      fontSize: UIConstants.fontSizeBody,
                      fontWeight: UIConstants.fontWeightNormal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    final isSelected = item.isSelected;
    final color = UIConstants.textPrimary(widget.isDarkTheme);
    final selectedColor = UIConstants.menuSelectedColor(widget.isDarkTheme);

    return Tooltip(
      message: _isExpanded ? '' : item.label,
      child: InkWell(
        onTap: item.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: UIConstants.paddingSm,
            vertical: 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.paddingMd,
            vertical: UIConstants.paddingMd,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? UIConstants.menuSelectedBackground(widget.isDarkTheme)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                color: isSelected ? selectedColor : color,
                size: 22,
              ),
              if (_isExpanded) ...[
                const SizedBox(width: UIConstants.spacingMd),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? selectedColor : color,
                      fontSize: UIConstants.fontSizeBody,
                      fontWeight: isSelected ? UIConstants.fontWeightMedium : UIConstants.fontWeightNormal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}