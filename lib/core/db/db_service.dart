import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class DBService {
  static final DBService _dBService = DBService._internal();

  factory DBService() => _dBService;

  DBService._internal();

  static String userTable = 'user';
  static String qazoTable = 'qazo';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2,
      onUpgrade: _onUpgrade,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $userTable");
    await db.execute(
      'CREATE TABLE $userTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, userLanguage TEXT, isMan INTEGER)',
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // user
    await db.execute(
      'CREATE TABLE $userTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, userLanguage TEXT, isMan INTEGER)',
    );
  }

  /// user

  Future<void> insertUserdata(UserModel usermodel) async {
    final db = await _dBService.database;
    print(usermodel.toJson().values.toList());
    await db.insert(
      userTable,
      usermodel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> getUserData() async {
    final db = await _dBService.database;
    final List<Map<String, dynamic>> maps = await db.query(userTable);
    if (maps.isNotEmpty) {
      return UserModel(
          id: maps[0]['id'],
          name: maps[0]['name'],
          isMan: maps[0]['isMan'] == 1,
          userLanguage: maps[0]['userLanguage']);
    } else {
      return null;
    }
  }

  Future<void> updateUser(UserModel usermodel) async {
    final db = await _dBService.database;
    await db.update(
      userTable,
      usermodel.toJson(),
      where: 'id = ?',
      whereArgs: [usermodel.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await _dBService.database;
    await db.delete(
      userTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
