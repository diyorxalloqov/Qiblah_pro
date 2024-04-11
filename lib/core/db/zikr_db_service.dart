import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class ZikrDBSevice {
  static final ZikrDBSevice _zikrDBService = ZikrDBSevice._internal();

  factory ZikrDBSevice() => _zikrDBService;

  ZikrDBSevice._internal();

  static String getCategegoryTable() {
    final lang = StorageRepository.getString(Keys.lang);
    debugPrint(lang.toString());
    return lang == 'uz' ? categoryUzb : categoryRus;
  }

  static String categoryRus = 'categoryRus';
  static String categoryUzb = "categoryUzb";
  static String zikr = "zikr";

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
    await db.execute("DROP TABLE IF EXISTS $categoryUzb");
    await db.execute("DROP TABLE IF EXISTS $categoryRus");
    await db.execute("DROP TABLE IF EXISTS $zikr");
    await db.execute(
      'CREATE TABLE $categoryUzb(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,category_id TEXT, category_name TEXT, category_lang TEXT,category_version INTEGER,category_background_color TEXT,category_text_color TEXT,category_image_link TEXT)',
    );
    await db.execute(
      'CREATE TABLE $categoryRus(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,category_id TEXT, category_name TEXT, category_lang TEXT,category_version INTEGER,category_background_color TEXT,category_text_color TEXT,category_image_link TEXT)',
    );
    await db.execute(
      'CREATE TABLE $zikr(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,zikr_id TEXT, zikr_title TEXT,zikr_description TEXT,zikr_info TEXT,zikr_daily_count INTEGER,zikr_audio_link TEXT,favourite_count INTEGER,category_id TEXT,category_name TEXT,category_version INTEGER,category_lang TEXT)',
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // zikrCategory
    await db.execute(
      'CREATE TABLE $categoryUzb(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,category_id TEXT, category_name TEXT, category_lang TEXT,category_version INTEGER,category_background_color TEXT,category_text_color TEXT,category_image_link TEXT)',
    );
    await db.execute(
      'CREATE TABLE $categoryRus(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,category_id TEXT, category_name TEXT, category_lang TEXT,category_version INTEGER,category_background_color TEXT,category_text_color TEXT,category_image_link TEXT)',
    );
    await db.execute(
      'CREATE TABLE $zikr(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,zikr_id TEXT, zikr_title TEXT,zikr_description TEXT,zikr_info TEXT,zikr_daily_count INTEGER,zikr_audio_link TEXT,favourite_count INTEGER,category_id TEXT,category_name TEXT,category_version INTEGER,category_lang TEXT,zikr_audio_name TEXT,isSaved INTEGER,today_zikrs INTEGER,all_zikrs INTEGER)',
    );
  }

  Future<void> insertCategory(ZikrCategoryModel zikrCategory) async {
    final db = await _zikrDBService.database;
    try {
      await db.insert(
        getCategegoryTable(),
        zikrCategory.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
    debugPrint("${getCategegoryTable().length} zikr table length from insert");
  }

  Future<List<ZikrCategoryModel>?> getCategory() async {
    final db = await _zikrDBService.database;
    final List<Map<String, dynamic>> maps =
        await db.query(getCategegoryTable());
    debugPrint("${maps.length} data length from db");
    return List.generate(maps.length, (i) {
      return ZikrCategoryModel.fromJson(maps[i]);
    });
  }

  Future<void> insertZikrs(ZikrModel zikrModel) async {
    final db = await _zikrDBService.database;
    try {
      await db.transaction((txn) async {
        await txn.insert(zikr, zikrModel.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      });
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
    debugPrint("${zikr.length} zikr table length from insert");
  }

  Future<List<ZikrModel>?> getZikrs(String categoryId) async {
    final db = await _zikrDBService.database;
    debugPrint("$categoryId CATEGORY ID");
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        zikr,
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );
      debugPrint("$maps DATA FROM DB IS GET zikr BY ID");

      if (maps.isNotEmpty) {
        debugPrint("$maps is not empty maps");
        return List.generate(maps.length, (i) {
          return ZikrModel.fromJson(maps[i]);
        });
      } else {
        // If no data is found, return an empty list
        debugPrint("No item found in the database with sura_id $categoryId");
        return [];
      }
    } on DatabaseException catch (e) {
      // Handle any database exceptions
      debugPrint("${e.toString()} database Exception");
      return null;
    }
  }

  Future<List<ZikrModel>?> getAllZikr() async {
    final db = await _zikrDBService.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(zikr);
      debugPrint("$maps DATA FROM DB IS GET ALL ZIKR");

      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return ZikrModel.fromJson(maps[i]);
        });
      } else {
        debugPrint("No item found in the database");
        return [];
      }
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
      return null;
    }
  }

  Future<void> updateSaved(String zikrId, bool isSaved) async {
    final db = await _zikrDBService.database;
    try {
      await db.transaction((txn) async {
        // transation is used to for db is working well
        await txn.update(zikr, {"isSaved": isSaved ? 1 : 0},
            where: 'zikr_id = ?',
            whereArgs: [zikrId],
            conflictAlgorithm: ConflictAlgorithm.replace);
        debugPrint('isSaved $isSaved updated successfully id is $zikrId');
      });
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
  }

  Future<List<ZikrModel>?> getSavedZikrs() async {
    final db = await _zikrDBService.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        zikr,
        where: 'isSaved = ?',
        whereArgs: [1], // 1 represents true for the isSaved attribute
      );
      debugPrint(maps.toString());

      // If data is found, convert the maps to a list of ZikrModel objects
      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return ZikrModel.fromJson(maps[i]);
        });
      } else {
        // If no data is found, return an empty list
        debugPrint("No saved zikrs found in the database");
        return [];
      }
    } on DatabaseException catch (e) {
      // Handle any database exceptions
      debugPrint("Database Exception: ${e.toString()}");
      return null;
    }
  }

  Future<void> updateZikrCount(
      String zikrId, int allZikrs, int todayZikrs) async {
    final db = await _zikrDBService.database;
    try {
      await db.transaction((txn) async {
        // transation is used to for db is working well
        await txn.update(
            zikr, {"all_zikrs": allZikrs, "today_zikrs": todayZikrs},
            where: 'zikr_id = ?',
            whereArgs: [zikrId],
            conflictAlgorithm: ConflictAlgorithm.replace);
        debugPrint(
            'zikr count $allZikrs $todayZikrs updated successfully id is $zikrId');
      });
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
  }

  Future<void> resetTodayZikrs() async {
    final db = await _zikrDBService.database;
    try {
      await db.transaction((txn) async {
        await txn.update(
          zikr,
          {"today_zikrs": 0},
        );
        debugPrint('All today_zikrs updated to 0 successfully');
      });
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
  }

  Future<void> clearDatabase() async {
    final db = await _zikrDBService.database;
    await db.delete(zikr);
    debugPrint('db cleared successfully');
  }
}
