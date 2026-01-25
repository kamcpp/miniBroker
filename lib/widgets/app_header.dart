import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../config/ui_constants.dart';
import '../screens/profile_page.dart';
import '../screens/login_page.dart';

/// Reusable application header component
/// Displays logo, profile button, theme toggle, and logout button
class AppHeader extends StatelessWidget {
  final bool isDarkTheme;
  final VoidCallback? onThemeToggle;

  const AppHeader({
    super.key,
    required this.isDarkTheme,
    this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final themeService = Provider.of<ThemeService>(context, listen: false);

    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1a1754) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDarkTheme ? Colors.white24 : Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          _buildLogo(isDarkTheme),

          // Right side controls
          Row(
            children: [
              // Profile Button
              _buildProfileButton(context, authService, isDarkTheme),

              const SizedBox(width: UIConstants.spacingMd),

              // Theme Toggle
              _buildThemeToggle(themeService, isDarkTheme),

              const SizedBox(width: UIConstants.spacingMd),

              // Logout Button
              _buildLogoutButton(context, authService, isDarkTheme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(bool isDarkTheme) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/logo.png',
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: UIConstants.spacingSm),
        Text(
          'miniBroker',
          style: TextStyle(
            fontSize: UIConstants.fontSizeLg,
            fontWeight: UIConstants.fontWeightMedium,
            color: isDarkTheme ? Colors.white : const Color(0xFF1a1754),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileButton(BuildContext context, AuthService authService, bool isDarkTheme) {
    return Tooltip(
      message: 'Profile',
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        },
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.paddingMd,
            vertical: UIConstants.paddingSm,
          ),
          decoration: BoxDecoration(
            color: isDarkTheme ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_circle,
                color: isDarkTheme ? Colors.white : const Color(0xFF1a1754),
                size: 20,
              ),
              const SizedBox(width: UIConstants.spacingSm),
              Text(
                authService.username,
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : const Color(0xFF1a1754),
                  fontSize: UIConstants.fontSizeBody,
                  fontWeight: UIConstants.fontWeightMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(ThemeService themeService, bool isDarkTheme) {
    return Tooltip(
      message: isDarkTheme ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      child: IconButton(
        icon: Icon(
          isDarkTheme ? Icons.light_mode : Icons.dark_mode,
          color: isDarkTheme ? Colors.white : const Color(0xFF1a1754),
        ),
        onPressed: () {
          themeService.toggleTheme();
          if (onThemeToggle != null) {
            onThemeToggle!();
          }
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthService authService, bool isDarkTheme) {
    return Tooltip(
      message: 'Logout',
      child: ElevatedButton.icon(
        onPressed: () async {
          final shouldLogout = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirm Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ),
          );

          if (shouldLogout == true && context.mounted) {
            await authService.logout();
            // Navigate to root and clear navigation stack
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            }
          }
        },
        icon: const Icon(Icons.logout, size: UIConstants.textFieldIconSize),
        label: const Text('Logout', style: TextStyle(fontSize: UIConstants.fontSizeBody)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkTheme ? Colors.red.shade700 : Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.paddingMd,
            vertical: UIConstants.paddingSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
          ),
        ),
      ),
    );
  }
}