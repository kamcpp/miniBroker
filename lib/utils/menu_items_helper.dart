import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/left_menu.dart';
import '../screens/securities_page.dart';
import '../screens/portfolio_page.dart';
import '../screens/trading_page.dart';
import '../screens/broker/broker_info_page.dart';
import '../screens/broker/execution_reports_page.dart';
import '../screens/investor/investor_info_page.dart';
import '../services/auth_service.dart';
// import '../screens/activity_page.dart';  // Disabled
// import '../screens/cash_management_page.dart';  // Removed
// import '../screens/users_admin_page.dart';  // Disabled

/// Helper class to build consistent menu items across all pages
class MenuItemsHelper {
  /// Build menu items for all pages with the specified page selected
  static List<MenuItem> buildMenuItems(
    BuildContext context,
    String currentPage,
  ) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final role = authService.userRole;

    return [
      // Securities - shown for both roles
      MenuItem(
        label: 'Securities',
        icon: Icons.list_alt,
        isSelected: currentPage == 'securities',
        onTap: () {
          if (currentPage != 'securities') {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const SecuritiesPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
      // Investor-only pages
      if (role == UserRole.investor)
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
      if (role == UserRole.investor)
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
      if (role == UserRole.investor)
        MenuItem(
          label: 'Investor Info',
          icon: Icons.person,
          isSelected: currentPage == 'investor_info',
          onTap: () {
            if (currentPage != 'investor_info') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const InvestorInfoPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      // Broker-only pages
      if (role == UserRole.broker)
        MenuItem(
          label: 'Exec Reports',
          icon: Icons.receipt_long,
          isSelected: currentPage == 'execution_reports',
          onTap: () {
            if (currentPage != 'execution_reports') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const ExecutionReportsPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      if (role == UserRole.broker)
        MenuItem(
          label: 'Broker Info',
          icon: Icons.business,
          isSelected: currentPage == 'broker_info',
          onTap: () {
            if (currentPage != 'broker_info') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const BrokerInfoPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      // Activity - Disabled
      // MenuItem(
      //   label: 'Activity',
      //   icon: Icons.history,
      //   isSelected: currentPage == 'activity',
      //   onTap: () {
      //     if (currentPage != 'activity') {
      //       Navigator.of(context).pushReplacement(
      //         PageRouteBuilder(
      //           pageBuilder: (context, animation, secondaryAnimation) => const ActivityPage(),
      //           transitionDuration: Duration.zero,
      //           reverseTransitionDuration: Duration.zero,
      //         ),
      //       );
      //     }
      //   },
      // ),
      // Users Admin - Disabled
      // MenuItem(
      //   label: 'Users Admin',
      //   icon: Icons.admin_panel_settings,
      //   isSelected: currentPage == 'users',
      //   onTap: () {
      //     Navigator.of(context).push(
      //       PageRouteBuilder(
      //         pageBuilder: (context, animation, secondaryAnimation) => const UsersAdminPage(),
      //         transitionDuration: Duration.zero,
      //         reverseTransitionDuration: Duration.zero,
      //       ),
      //     );
      //   },
      // ),
    ];
  }
}
