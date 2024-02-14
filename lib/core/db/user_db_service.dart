import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class UserDBService {
  static final UserDBService _userDbService = UserDBService._internal();

  factory UserDBService() => _userDbService;

  UserDBService._internal();

  static String userTable = 'user';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'user.db');
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
      'CREATE TABLE $userTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT,userLanguage TEXT,isMan INTEGER)',
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // user
    await db.execute(
      'CREATE TABLE $userTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT,userLanguage TEXT,isMan INTEGER)',
    );
  }

  /// user

  Future<void> insertUserdata(UserModel usermodel) async {
    final db = await _userDbService.database;
    try {
      await db.insert(userTable, usermodel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } on DatabaseException catch (e) {
      print("${e.toString()} database Exception");
    }
    print("${userTable.length} user table length from insert");
  }

  Future<UserModel> getUserData() async {
    final db = await _userDbService.database;
    final List<Map<String, dynamic>> maps = await db.query(userTable);
    print("${maps.length} data length from db");

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      return UserModel();
    }
  }

  Future<void> clearDatabase() async {
    final db = await _userDbService.database;
    await db.delete(userTable);
    print('db cleared successfully');
  }

  Future<void> updateUser(UserModel usermodel) async {
    final db = await _userDbService.database;
    await db.update(
      userTable,
      usermodel.toJson(),
      where: 'id = ?',
      whereArgs: [usermodel.id],
    );
  }
}
