import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/left_menu.dart';
import '../screens/securities_page.dart';
import '../screens/portfolio_page.dart';
import '../screens/trading_page.dart';
import '../screens/broker/broker_info_page.dart';
import '../screens/broker/execution_reports_page.dart';
import '../screens/broker/investors_page.dart';
import '../screens/broker/local_accounts_page.dart';
import '../screens/broker/trade_reports_page.dart';
import '../screens/broker/treasury_activities_page.dart';
import '../screens/broker/agora_events_page.dart';
import '../screens/broker/security_orderbooks_page.dart';
import '../screens/broker/orders_page.dart';
import '../screens/broker/workflows_page.dart';
import '../screens/investor/investor_info_page.dart';
import '../screens/investor/event_messages_page.dart';
import '../screens/transaction_history_page.dart';
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
      // Sec. Orderbooks - right after Securities, broker only
      if (role == UserRole.broker)
        MenuItem(
          label: 'Sec. Orderbooks',
          icon: Icons.menu_book,
          isSelected: currentPage == 'security_orderbooks',
          onTap: () {
            if (currentPage != 'security_orderbooks') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const SecurityOrderbooksPage(),
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
          label: 'Transactions',
          icon: Icons.receipt_long,
          isSelected: currentPage == 'transaction_history',
          onTap: () {
            if (currentPage != 'transaction_history') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const TransactionHistoryPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      if (role == UserRole.investor)
        MenuItem(
          label: 'Event Messages',
          icon: Icons.message,
          isSelected: currentPage == 'event_messages',
          onTap: () {
            if (currentPage != 'event_messages') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const EventMessagesPage(),
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
          label: 'Orders',
          icon: Icons.shopping_cart,
          isSelected: currentPage == 'orders',
          onTap: () {
            if (currentPage != 'orders') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const OrdersPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
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
          label: 'Trade Reports',
          icon: Icons.swap_horiz,
          isSelected: currentPage == 'trade_reports',
          onTap: () {
            if (currentPage != 'trade_reports') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const TradeReportsPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      if (role == UserRole.broker)
        MenuItem(
          label: 'Treasury',
          icon: Icons.account_balance,
          isSelected: currentPage == 'treasury_activities',
          onTap: () {
            if (currentPage != 'treasury_activities') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const TreasuryActivitiesPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      if (role == UserRole.broker)
        MenuItem(
          label: 'Agora Events',
          icon: Icons.bolt,
          isSelected: currentPage == 'agora_events',
          onTap: () {
            if (currentPage != 'agora_events') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const AgoraEventsPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      if (role == UserRole.broker)
        MenuItem(
          label: 'Workflows',
          icon: Icons.account_tree,
          isSelected: currentPage == 'workflows',
          onTap: () {
            if (currentPage != 'workflows') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const WorkflowsPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      if (role == UserRole.broker)
        MenuItem(
          label: 'Local Accounts',
          icon: Icons.people,
          isSelected: currentPage == 'local_accounts',
          onTap: () {
            if (currentPage != 'local_accounts') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const LocalAccountsPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          },
        ),
      if (role == UserRole.broker)
        MenuItem(
          label: 'Investors',
          icon: Icons.group,
          isSelected: currentPage == 'investors',
          onTap: () {
            if (currentPage != 'investors') {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const InvestorsPage(),
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
