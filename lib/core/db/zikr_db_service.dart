import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/zikr_model.dart';

class ZikrDBSevice {
  static final ZikrDBSevice _namesDBService = ZikrDBSevice._internal();

  factory ZikrDBSevice() => _namesDBService;

  ZikrDBSevice._internal();

  static String namesTable = 'zikr';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'zikr.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $namesTable");
    await db.execute(
      'CREATE TABLE $namesTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, category_name TEXT, category_lang TEXT,category_version INTEGER)',
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // user
    await db.execute(
      'CREATE TABLE $namesTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, category_name TEXT, category_lang TEXT,category_version INTEGER)',
    );
  }

  /// user

  Future<void> insertZikrs(ZikrModel zikrModel) async {
    final db = await _namesDBService.database;
    try {
      await db.insert(
        namesTable,
        {
          "category_name": zikrModel.categoryName,
          "category_lang": zikrModel.categoryLang,
          "category_version": zikrModel.categoryVersion,
        },
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on DatabaseException catch (e) {
      print("${e.toString()} database Exception");
    }
    print("${namesTable.length} names table length from insert");
  }

  Future<List<ZikrModel>?> getZikrs() async {
    final db = await _namesDBService.database;
    final List<Map<String, dynamic>> maps = await db.query(namesTable);
    print("${maps.length} data length from db");
    return List.generate(maps.length, (i) {
      return ZikrModel(
        categoryName: maps[i]['category_name'],
        categoryLang: maps[i]['category_lang'],
        categoryVersion: maps[i]['category_version'],
      );
    });
  }

  Future<void> clearDatabase() async {
    final db = await _namesDBService.database;
    await db.delete(namesTable);
    print('db cleared successfully');
  }
}
