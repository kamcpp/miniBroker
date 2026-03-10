import 'package:flutter/material.dart';
import 'dart:ui';
import '../config/app_config.dart';
import '../config/ui_constants.dart';
import '../main.dart';
import '../widgets/copyright_bar.dart';
import 'login_page.dart';
import 'broker/broker_login_page.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  void _goBackToConfigSelection(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MyApp()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UIConstants.preLoginBackground(),
          // Broker name and settings in top-right
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (AppConfig.selectedBrokerName != null)
                  UIConstants.brokerNameChip(AppConfig.selectedBrokerName!),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _goBackToConfigSelection(context),
                  icon: const Icon(Icons.settings, color: Colors.white, size: 28),
                  tooltip: 'Change Configuration',
                  style: UIConstants.preLoginIconButtonStyle(),
                ),
              ],
            ),
          ),
          // Main content - role selection cards
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: UIConstants.glassBlurSigma,
                  sigmaY: UIConstants.glassBlurSigma,
                ),
                child: Container(
                  width: 400,
                  padding: const EdgeInsets.all(40.0),
                  decoration: UIConstants.glassCardDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select Login Type',
                        style: TextStyle(
                          fontSize: UIConstants.fontSizeXl,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Broker Login button
                      _buildRoleCard(
                        context,
                        icon: Icons.business,
                        title: 'Broker Login',
                        subtitle: 'Administrative access',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BrokerLoginPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Investor Login button
                      _buildRoleCard(
                        context,
                        icon: Icons.person,
                        title: 'Investor Login',
                        subtitle: 'Trading & portfolio access',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Copyright bar
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CopyrightBar(isDarkTheme: true),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(UIConstants.glassCardOpacity),
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
            border: Border.all(
              color: Colors.white.withOpacity(UIConstants.chipBorderOpacity),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: UIConstants.colorCommand.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.5),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
