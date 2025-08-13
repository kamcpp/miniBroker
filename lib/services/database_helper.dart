import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mini_broker.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
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
          'created_at': DateTime.now().toIso8601String(),
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
      final db = await database;
      
      // Check if admin user exists
      final adminExists = await isUsernameExists('admin');
      
      if (!adminExists) {
        await _createDefaultAdminUser(db);
      }
    } catch (e) {
      print('Error ensuring admin user exists: $e');
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
          'created_at': DateTime.now().toIso8601String(),
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
          {'last_login': DateTime.now().toIso8601String()},
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

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
