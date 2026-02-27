import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database_helper.dart';
import '../services/user_sync_service.dart';
import '../services/theme_service.dart';
import '../config/ui_constants.dart';
import '../utils/menu_items_helper.dart';
import '../widgets/base_page.dart';
class UsersAdminPage extends StatefulWidget {
  const UsersAdminPage({super.key});

  @override
  State<UsersAdminPage> createState() => _UsersAdminPageState();
}

class _UsersAdminPageState extends State<UsersAdminPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final UserSyncService _userSyncService = UserSyncService();
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;
  bool _isSyncing = false;

  /// Parse Unix timestamp to DateTime, handling both int and string inputs
  DateTime? _parseUnixTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;
    
    int? unixTime;
    if (timestamp is int) {
      unixTime = timestamp;
    } else if (timestamp is String) {
      unixTime = int.tryParse(timestamp);
    }
    
    if (unixTime != null) {
      return DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    }
    
    // Fallback to try ISO8601 parsing for backward compatibility
    if (timestamp is String) {
      return DateTime.tryParse(timestamp);
    }
    
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _isSyncing = true;
    });

    try {
      print('🔄 Loading synchronized users...');
      
      // Get synchronized users (this will call server and sync automatically)
      final users = await _userSyncService.getSynchronizedUsers();
      
      setState(() {
        _users = users;
        _isLoading = false;
        _isSyncing = false;
      });
            
    } catch (e) {
      print('Error loading synchronized users: $e');
      setState(() {
        _isLoading = false;
        _isSyncing = false;
      });
    }
  }

  Future<void> _deleteUser(String username) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete user "$username"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await _databaseHelper.deleteUser(username);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User "$username" deleted successfully')),
        );
        _loadUsers(); // Refresh the list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete user'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'users'),
      content: Column(
        children: [
          // Title and Refresh Button
          Padding(
            padding: UIConstants.paddingStandard,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Registered Users',
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeLg,
                    fontWeight: UIConstants.fontWeightMedium,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  onPressed: _loadUsers,
                  tooltip: 'Refresh',
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: isDarkTheme ? Colors.white : UIConstants.colorCommand,
                        ),
                        const SizedBox(height: UIConstants.spacingMd),
                        Text(
                          _isSyncing ? 'Syncing with server...' : 'Loading users...',
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontSize: UIConstants.fontSizeBody,
                          ),
                        ),
                      ],
                    ),
                  )
                : _users.isEmpty
                    ? Center(
                        child: Text(
                          'No users registered yet',
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontSize: UIConstants.fontSizeMd,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: UIConstants.paddingStandard,
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          final user = _users[index];
                          final createdAt = _parseUnixTimestamp(user['created_at']);
                          final lastLogin = _parseUnixTimestamp(user['last_login']);

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: UIConstants.colorCommand,
                                child: Text(
                                  user['username']?.substring(0, 1).toUpperCase() ?? 'U',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: UIConstants.fontWeightMedium,
                                  ),
                                ),
                              ),
                              title: Text(
                                user['username'] ?? 'Unknown',
                                style: const TextStyle(fontWeight: UIConstants.fontWeightMedium),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ID: ${user['id']}'),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      // Local database status
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(color: Colors.green, width: 1),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.check_circle, color: Colors.green, size: 12),
                                            SizedBox(width: 4),
                                            Text(
                                              'Local DB',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Server status
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: (user['exists_on_server'] == 1 ? Colors.blue : Colors.grey).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            color: user['exists_on_server'] == 1 ? Colors.blue : Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              user['exists_on_server'] == 1 ? Icons.cloud_done : Icons.cloud_off,
                                              color: user['exists_on_server'] == 1 ? Colors.blue : Colors.grey,
                                              size: 12,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              user['exists_on_server'] == 1 ? 'On Server' : 'Not on Server',
                                              style: TextStyle(
                                                color: user['exists_on_server'] == 1 ? Colors.blue : Colors.grey,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  if (createdAt != null)
                                    Text('Created: ${_formatDate(createdAt)}'),
                                  if (lastLogin != null)
                                    Text('Last Login: ${_formatDate(lastLogin)}')
                                  else
                                    const Text('Last Login: Never'),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteUser(user['username']),
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
