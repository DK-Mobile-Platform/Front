//sqlite를 이용한 로그인과 회원가입 구현

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> getDB() async {
    if (_db != null) {
      return _db!;
    }
    await _initDatabaseFactory();
    _db = await initDB();
    return _db!;
  }

  static Future<void> _initDatabaseFactory() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfiWeb;
  }

  static initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, username TEXT, password TEXT, name TEXT, country TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertUser(User user) async {
    final db = await getDB();
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<User?> getUser(String id, String password) async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ? AND password = ?',
      whereArgs: [id, password],
    );
    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        username: maps[0]['username'],
        password: maps[0]['password'],
        country: maps[0]['country'],
      );
    }
    return null;
  }
}