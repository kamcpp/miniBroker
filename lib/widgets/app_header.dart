import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/event_subscription_service.dart';
import '../config/app_config.dart';
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
        color: UIConstants.headerBackground(isDarkTheme),
        border: Border(
          bottom: BorderSide(
            color: UIConstants.borderColor(isDarkTheme),
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
              // Heartbeat indicator
              _HeartbeatIndicator(isDarkTheme: isDarkTheme),

              const SizedBox(width: UIConstants.spacingMd),

              // Profile Button
              _buildProfileButton(context, authService, isDarkTheme),

              const SizedBox(width: UIConstants.spacingMd),

              // Theme Toggle
              _buildThemeToggle(themeService, isDarkTheme),

              const SizedBox(width: UIConstants.spacingMd),

              // New Instance
              Tooltip(
                message: 'New Instance',
                child: IconButton(
                  onPressed: () => Process.start(Platform.resolvedExecutable, [], mode: ProcessStartMode.detached),
                  icon: Icon(Icons.open_in_new, color: UIConstants.textPrimary(isDarkTheme), size: 20),
                ),
              ),

              const SizedBox(width: UIConstants.spacingSm),

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
          'Agora miniBroker (v${AppConfig.appVersion})',
          style: TextStyle(
            fontSize: UIConstants.fontSizeLg,
            fontWeight: UIConstants.fontWeightMedium,
            color: UIConstants.textPrimary(isDarkTheme),
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
            color: UIConstants.menuSelectedBackground(isDarkTheme),
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_circle,
                color: UIConstants.textPrimary(isDarkTheme),
                size: 20,
              ),
              const SizedBox(width: UIConstants.spacingSm),
              Text(
                authService.username,
                style: TextStyle(
                  color: UIConstants.textPrimary(isDarkTheme),
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
      message: 'Coming soon ...',
      child: IconButton(
        icon: Icon(
          isDarkTheme ? Icons.light_mode : Icons.dark_mode,
          color: UIConstants.textHint(isDarkTheme),
        ),
        onPressed: null,
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
              backgroundColor: UIConstants.dialogBackground(isDarkTheme),
              shape: UIConstants.dialogShape(isDarkTheme),
              title: Text('Confirm Logout', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme))),
              content: Text('Are you sure you want to logout?', style: TextStyle(color: UIConstants.textSecondary(isDarkTheme))),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: UIConstants.cancelTextButtonStyle(isDarkTheme),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: UIConstants.dangerButtonStyle(),
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
        style: UIConstants.buttonStyle(UIConstants.colorReject),
      ),
    );
  }
}

/// Animated heartbeat indicator that pulses when gRPC heartbeats arrive.
class _HeartbeatIndicator extends StatefulWidget {
  final bool isDarkTheme;
  const _HeartbeatIndicator({required this.isDarkTheme});

  @override
  State<_HeartbeatIndicator> createState() => _HeartbeatIndicatorState();
}

class _HeartbeatIndicatorState extends State<_HeartbeatIndicator> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Pulse animation (scale up/down on heartbeat)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    // Fade animation: 1.0 (red) → 0.0 (gray) over 20 seconds
    _fadeController = AnimationController(
      duration: const Duration(seconds: 29),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    // Start fading immediately
    _fadeController.forward();

    EventSubscriptionService().heartbeat.addListener(_onHeartbeat);
  }

  void _onHeartbeat() {
    if (mounted) {
      // Reset color to red and restart fade
      _fadeController.reset();
      _fadeController.forward();
      // Pulse
      _pulseController.forward().then((_) => _pulseController.reverse());
    }
  }

  @override
  void dispose() {
    EventSubscriptionService().heartbeat.removeListener(_onHeartbeat);
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionIid = EventSubscriptionService().sessionIid;
    final tooltipMsg = sessionIid != null && sessionIid.isNotEmpty
        ? 'Session: $sessionIid'
        : 'Server heartbeat (no session)';

    return Tooltip(
      message: tooltipMsg,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            final color = Color.lerp(Colors.grey, Colors.red.shade400, _fadeAnimation.value)!;
            return Icon(
              Icons.favorite,
              size: 14,
              color: color,
            );
          },
        ),
      ),
    );
  }
}