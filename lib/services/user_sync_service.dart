import 'database_helper.dart';
import 'real_grpc_client.dart';

/// Service to synchronize local SQLite users with server accounts
/// Keeps only users that exist on both sides (except admin)
class UserSyncService {
  static final UserSyncService _instance = UserSyncService._internal();
  factory UserSyncService() => _instance;
  UserSyncService._internal();

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final RealGrpcClient _grpcClient = realGrpcClient;

  /// Get synchronized users - calls server first, then syncs local database
  /// Admin user is always preserved even if not on server
  Future<List<Map<String, dynamic>>> getSynchronizedUsers() async {
    try {
      // Get server accounts
      final serverResponse = await _grpcClient.getInvestorList();
      if (serverResponse['success'] == true &&
          serverResponse['output'] != null &&
          serverResponse['output']['accounts'] != null) {

        final serverAccounts = List<Map<String, dynamic>>.from(
          serverResponse['output']['accounts']
        );
        // Sync local database with server
        return await _databaseHelper.getSynchronizedUsersWithServerData(serverAccounts);
        
      } else {
        print('⚠️ Could not get server accounts for sync: ${serverResponse['output']}');
        print('⚠️ Falling back to local users only');
        
        // Fallback to local users if server is unavailable
        return await _databaseHelper.getAllUsers();
      }
      
    } catch (e) {
      print('❌ Sync failed, returning local users only: $e');
      
      // Fallback to local users if sync fails completely
      return await _databaseHelper.getAllUsers();
    }
  }
  
  /// Force sync without returning users
  Future<bool> syncUsers() async {
    try {
      await getSynchronizedUsers();
      return true;
    } catch (e) {
      print('❌ Force sync failed: $e');
      return false;
    }
  }
  
  /// Get local users only (no server sync)
  Future<List<Map<String, dynamic>>> getLocalUsersOnly() async {
    return await _databaseHelper.getAllUsers();
  }
  
  /// Check if sync is needed (for debugging/monitoring)
  Future<Map<String, dynamic>> getSyncStatus() async {
    try {
      final localUsers = await _databaseHelper.getAllUsers();
      final serverResponse = await _grpcClient.getInvestorList();
      
      final serverAccounts = (serverResponse['success'] == true && 
                            serverResponse['output'] != null && 
                            serverResponse['output']['accounts'] != null)
          ? List<Map<String, dynamic>>.from(serverResponse['output']['accounts'])
          : <Map<String, dynamic>>[];
      
      final serverExternalIds = serverAccounts
          .map((account) => account['externalAccountId'] as String?)
          .where((id) => id != null)
          .cast<String>()
          .toSet();
      
      final localUsernames = localUsers
          .map((user) => user['username'] as String)
          .toSet();

      return {
        'local_users_count': localUsers.length,
        'server_accounts_count': serverAccounts.length,
        'local_usernames': localUsernames.toList(),
        'server_external_ids': serverExternalIds.toList(),
        'users_only_local': localUsernames.difference(serverExternalIds).toList(),
        'users_only_server': serverExternalIds.difference(localUsernames).toList(),
        'users_on_both': localUsernames.intersection(serverExternalIds).toList(),
      };
    } catch (e) {
      return {
        'error': e.toString(),
        'local_users_count': 0,
        'server_accounts_count': 0,
      };
    }
  }
}