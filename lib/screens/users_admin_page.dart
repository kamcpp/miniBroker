import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../services/user_sync_service.dart';

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
      
      print('✅ Synchronized users loaded: ${users.length}');
      
      // Show sync result in snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Users synchronized with server (${users.length} users)'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error loading synchronized users: $e');
      setState(() {
        _isLoading = false;
        _isSyncing = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚠️ Sync failed, showing local users only'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _deleteUser(String username) async {
    // Check if trying to delete admin user
    if (_databaseHelper.isAdminUser(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Cannot delete admin user - admin user is protected'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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
    return Scaffold(
      backgroundColor: const Color(0xFF1a1754),
      appBar: AppBar(
        title: const Text('Registered Users'),
        backgroundColor: const Color(0xFF1a1754),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    _isSyncing ? 'Syncing with server...' : 'Loading users...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : _users.isEmpty
              ? const Center(
                  child: Text(
                    'No users registered yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    final createdAt = DateTime.tryParse(user['created_at'] ?? '');
                    final lastLogin = DateTime.tryParse(user['last_login'] ?? '');

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF1a1754),
                          child: Text(
                            user['username']?.substring(0, 1).toUpperCase() ?? 'U',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              user['username'] ?? 'Unknown',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            if (_databaseHelper.isAdminUser(user['username'] ?? '')) ...[
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.admin_panel_settings,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const Text(
                                ' (Admin)',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${user['id']}'),
                            if (createdAt != null)
                              Text('Created: ${_formatDate(createdAt)}'),
                            if (lastLogin != null)
                              Text('Last Login: ${_formatDate(lastLogin)}')
                            else
                              const Text('Last Login: Never'),
                          ],
                        ),
                        trailing: _databaseHelper.isAdminUser(user['username'] ?? '')
                            ? const Tooltip(
                                message: 'Admin user cannot be deleted',
                                child: Icon(
                                  Icons.shield,
                                  color: Colors.amber,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteUser(user['username']),
                              ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
