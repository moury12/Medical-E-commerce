import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DbHelper{
  static Database? _database;

  static const String tableName = 'login';
  static const String columnId = 'id';
  static const String columnAccessToken = 'access_token';

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'your_database.db');

    return openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnAccessToken TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertLoginData(String accessToken) async {
    final db = await database;
    await db.insert(
      tableName,
      {columnAccessToken: accessToken},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getAccessToken() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    if (maps.isNotEmpty) {
      return maps.first[columnAccessToken] as String?;
    }
    return null;
  }
}