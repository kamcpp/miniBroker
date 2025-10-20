import 'package:flutter/material.dart';
import '../widgets/left_menu.dart';
import '../screens/instruments_page.dart';
import '../screens/portfolio_page.dart';
import '../screens/trading_page.dart';
import '../screens/activity_page.dart';
import '../screens/cash_management_page.dart';
import '../screens/users_admin_page.dart';

/// Helper class to build consistent menu items across all pages
class MenuItemsHelper {
  /// Build menu items for all pages with the specified page selected
  static List<MenuItem> buildMenuItems(
    BuildContext context,
    String currentPage,
  ) {
    return [
      MenuItem(
        label: 'Instruments',
        icon: Icons.list_alt,
        isSelected: currentPage == 'instruments',
        onTap: () {
          if (currentPage != 'instruments') {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const InstrumentsPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
      MenuItem(
        label: 'Portfolio',
        icon: Icons.account_balance_wallet,
        isSelected: currentPage == 'portfolio',
        onTap: () {
          if (currentPage != 'portfolio') {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const PortfolioPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
      MenuItem(
        label: 'Trading',
        icon: Icons.candlestick_chart,
        isSelected: currentPage == 'trading',
        onTap: () {
          if (currentPage != 'trading') {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const TradingPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
      MenuItem(
        label: 'Activity',
        icon: Icons.history,
        isSelected: currentPage == 'activity',
        onTap: () {
          if (currentPage != 'activity') {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const ActivityPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
      MenuItem(
        label: 'Cash Management',
        icon: Icons.payments,
        isSelected: currentPage == 'cash',
        onTap: () {
          if (currentPage != 'cash') {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const CashManagementPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
      MenuItem(
        label: 'Users Admin',
        icon: Icons.admin_panel_settings,
        isSelected: currentPage == 'users',
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UsersAdminPage(),
            ),
          );
        },
      ),
    ];
  }
}
