import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
 static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('accounts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, filePath);

  return await openDatabase(
    path,
    version: 2, // Increment the version number to trigger the schema update
    onCreate: _createDB,
    onUpgrade: _onUpgrade,
  );
}

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        token TEXT,
        username TEXT,
        avatar TEXT
      )
    ''');
  }

 Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    await db.execute('ALTER TABLE accounts ADD COLUMN avatar TEXT');
  }
}

  Future<void> addAccount(String email, String token, String username, String avatar) async {
    final db = await instance.database;

    List<Map<String, dynamic>> accounts = await db.query(
      'accounts',
      columns: ['id'],
      where: 'email = ?',
      whereArgs: [email],
    );

    if (accounts.isNotEmpty) {
      await db.update(
        'accounts',
        {'token': token, 'username': username, 'avatar': avatar},
        where: 'email = ?',
        whereArgs: [email],
      );
    } else {
      await db.insert(
        'accounts',
        {'email': email, 'token': token, 'username': username, 'avatar': avatar},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }


  Future<String> getAccountToken(String email) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'accounts',
      columns: ['token'],
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first['token'] as String;
    } else {
      throw Exception('Account not found in database');
    }
  }


 Future<void> deleteAccount(String email, String username, String token) async {
  final db = await instance.database;
  await db.delete('accounts', where: 'email = ? AND username = ? AND token = ?', whereArgs: [email, username, token]);
}

  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await instance.database;
    return db.query('accounts');
  }
}

