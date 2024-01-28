import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  static final DBService _dBService = DBService._internal();

  factory DBService() => _dBService;

  DBService._internal();

  static String userTable = 'user';
  static String budgets = 'budgets';

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
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $userTable(id INTEGER PRIMARY KEY, name TEXT,userLanguage TEXT)',
    );
    // await db.execute(
    //   'CREATE TABLE $budgets(id INTEGER PRIMARY KEY,name TEXT,color_hex TEXT,  type TEXT, budget INTEGER, spent INTEGER,date DATETIME )',
    // );
  }

  Future<void> insertUserdata(UserModel usermodel) async {
    final db = await _dBService.database;
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
      );
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
