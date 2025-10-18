import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';
import '../utils/config_rc_manager.dart';

class DatabaseHelper {

  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  static String? _currentBrokerName;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  /// Initialize database with specific broker name
  /// This must be called before accessing the database
  void setBrokerName(String brokerName) {
    if (_currentBrokerName != brokerName) {
      // Close existing database if broker name changes
      _database?.close();
      _database = null;
      _currentBrokerName = brokerName;
      print('📊 Database broker name set to: $brokerName');
    }
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    if (_currentBrokerName == null) {
      throw Exception('Broker name must be set before accessing database. Call setBrokerName() first.');
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      // Get config directory from ConfigRcManager
      final configDir = ConfigRcManager.getCurrentConfigDir();
      print('📊 Config directory: $configDir');

      // Create database path: broker-{brokerName}.db
      final dbFileName = 'broker-$_currentBrokerName.db';
      final dbPath = join(configDir, dbFileName);

      // Ensure config directory exists
      final dir = Directory(configDir);
      if (!await dir.exists()) {
        print('📊 Creating config directory: $configDir');
        await dir.create(recursive: true);
      }

      print('📊 Database path: $dbPath');

      final db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: _createDatabase,
      );

      print('📊 Database opened successfully');
      return db;
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR initializing database: $e');
      print('❌ Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        created_at TEXT NOT NULL,
        last_login TEXT
      )
    ''');
    
    // Create default admin user
    await _createDefaultAdminUser(db);
  }

  // Create the default admin user that cannot be deleted
  Future<void> _createDefaultAdminUser(Database db) async {
    try {
      final hashedPassword = _hashPassword('111111');
      
      await db.insert(
        'users',
        {
          'username': 'admin',
          'password': hashedPassword,
          'created_at': _toUnixTimestamp(DateTime.now()),
        },
        conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore if admin already exists
      );
      
      print('✅ Default admin user created/verified');
    } catch (e) {
      print('Error creating default admin user: $e');
    }
  }

  // Ensure admin user exists (call this on app startup)
  Future<void> ensureAdminUserExists() async {
    try {
      print('📊 Ensuring admin user exists...');
      final db = await database;
      print('📊 Database instance obtained');

      // Check if admin user exists
      final adminExists = await isUsernameExists('admin');
      print('📊 Admin exists check: $adminExists');

      if (!adminExists) {
        print('📊 Creating default admin user...');
        await _createDefaultAdminUser(db);
        print('📊 Default admin user created');
      }
    } catch (e, stackTrace) {
      print('❌ Error ensuring admin user exists: $e');
      print('❌ Stack trace: $stackTrace');
      // Don't rethrow - just log the error to prevent app crash
    }
  }

  // Hash password using SHA-256
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Create a new user
  Future<bool> createUser(String username, String password) async {
    try {
      final db = await database;
      final hashedPassword = _hashPassword(password);
      
      await db.insert(
        'users',
        {
          'username': username.toLowerCase().trim(),
          'password': hashedPassword,
          'created_at': _toUnixTimestamp(DateTime.now()),
        },
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      
      return true;
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
  }

  // Verify user credentials
  Future<Map<String, dynamic>?> verifyUser(String username, String password) async {
    try {
      final db = await database;
      final hashedPassword = _hashPassword(password);
      
      final List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username.toLowerCase().trim(), hashedPassword],
      );
      
      if (results.isNotEmpty) {
        // Update last login time
        await db.update(
          'users',
          {'last_login': _toUnixTimestamp(DateTime.now())},
          where: 'id = ?',
          whereArgs: [results.first['id']],
        );
        
        return results.first;
      }
      
      return null;
    } catch (e) {
      print('Error verifying user: $e');
      return null;
    }
  }

  // Check if username already exists
  Future<bool> isUsernameExists(String username) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username.toLowerCase().trim()],
      );
      
      return results.isNotEmpty;
    } catch (e) {
      print('Error checking username: $e');
      return false;
    }
  }

  // Get user by username
  Future<Map<String, dynamic>?> getUser(String username) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username.toLowerCase().trim()],
      );
      
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Get all users (for debugging)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final db = await database;
      return await db.query('users');
    } catch (e) {
      print('Error getting all users: $e');
      return [];
    }
  }

  // Delete user (prevents deletion of admin user)
  Future<bool> deleteUser(String username) async {
    try {
      // Prevent deletion of admin user
      if (username.toLowerCase().trim() == 'admin') {
        print('❌ Cannot delete admin user - admin user is protected');
        return false;
      }
      
      final db = await database;
      final result = await db.delete(
        'users',
        where: 'username = ?',
        whereArgs: [username.toLowerCase().trim()],
      );
      
      return result > 0;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  // Check if user is the protected admin user
  bool isAdminUser(String username) {
    return username.toLowerCase().trim() == 'admin';
  }

  // Update user password
  Future<bool> updateUserPassword(String username, String newPassword) async {
    try {
      final db = await database;
      final hashedPassword = _hashPassword(newPassword);
      
      final result = await db.update(
        'users',
        {'password': hashedPassword},
        where: 'username = ?',
        whereArgs: [username.toLowerCase().trim()],
      );
      
      return result > 0;
    } catch (e) {
      print('Error updating user password: $e');
      return false;
    }
  }

  // Update username (if not admin)
  Future<bool> updateUsername(String oldUsername, String newUsername) async {
    try {
      // Prevent updating admin username
      if (isAdminUser(oldUsername)) {
        print('❌ Cannot update admin username');
        return false;
      }

      // Check if new username already exists
      final exists = await isUsernameExists(newUsername);
      if (exists) {
        print('❌ Username already exists');
        return false;
      }

      final db = await database;
      final result = await db.update(
        'users',
        {'username': newUsername.toLowerCase().trim()},
        where: 'username = ?',
        whereArgs: [oldUsername.toLowerCase().trim()],
      );
      
      return result > 0;
    } catch (e) {
      print('Error updating username: $e');
      return false;
    }
  }

  // Synchronize local users with server accounts
  Future<void> syncUsersWithServer(List<Map<String, dynamic>> serverAccounts) async {
    try {
      final db = await database;
      
      // Get all local users
      final localUsers = await getAllUsers();
      
      // Create set of server external IDs for quick lookup
      final serverExternalIds = serverAccounts
          .map((account) => account['externalId'] as String?)
          .where((id) => id != null)
          .cast<String>()
          .toSet();
      
      print('📊 Sync Status:');
      print('  - Local users: ${localUsers.length}');
      print('  - Server accounts: ${serverAccounts.length}');
      print('  - Server external IDs: $serverExternalIds');
      
      // Check each local user
      for (final user in localUsers) {
        final username = user['username'] as String;
        
        // Skip admin user - always keep locally
        if (isAdminUser(username)) {
          print('  ✅ Keeping admin user: $username (protected)');
          continue;
        }
        
        // Check if user exists on server
        if (serverExternalIds.contains(username)) {
          print('  ✅ Keeping user: $username (exists on server)');
        } else {
          print('  🗑️  Deleting user: $username (not found on server)');
          
          // Delete user from local database
          final deleted = await deleteUser(username);
          if (deleted) {
            print('  ✅ Successfully deleted: $username');
          } else {
            print('  ❌ Failed to delete: $username');
          }
        }
      }
      
      // Final count
      final remainingUsers = await getAllUsers();
      print('📊 Sync completed:');
      print('  - Remaining local users: ${remainingUsers.length}');
      
    } catch (e) {
      print('❌ Error syncing users with server: $e');
      rethrow;
    }
  }
  
  // Get synchronized users (requires external server accounts data)
  // This method should be called from a service that has access to RealGrpcClient
  Future<List<Map<String, dynamic>>> getSynchronizedUsersWithServerData(List<Map<String, dynamic>> serverAccounts) async {
    try {
      // Sync local database with server
      await syncUsersWithServer(serverAccounts);
      
      // Return synchronized local users
      return await getAllUsers();
    } catch (e) {
      print('⚠️ Sync failed, returning local users only: $e');
      // Fallback to local users if sync fails
      return await getAllUsers();
    }
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
