import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/oyat_model.dart';
import 'package:qiblah_pro/modules/home/models/quron_model.dart';

class QuronDBService {
  static final QuronDBService _quronDBService = QuronDBService._internal();

  factory QuronDBService() => _quronDBService;

  QuronDBService._internal();

  static String getSurahTable() {
    final lang = StorageRepository.getString(Keys.lang);
    return lang == 'uz' ? surahTableUzb : surahTableRus;
  }

  static String getOyatTable() {
    final lang = StorageRepository.getString(Keys.lang);
    return lang == 'uz' ? oyatTable : oyatTableRus;
  }

  static String surahTableUzb = "surahUzb";
  static String surahTableRus = 'surahRus';
  static String oyatTable = 'oyat';
  static String oyatTableRus = 'oyatRus';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// bug agar lang ozgarsa db ozgarmadi bitta hot restartdan keyin ozgardi

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'quron.db');
    try {
      return await openDatabase(
        path,
        onCreate: _onCreate,
        version: 1,
        onUpgrade: _onUpgrade,
        onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      );
    } catch (e) {
      debugPrint("Error initializing database: $e");
      rethrow; // Rethrow the exception for higher-level handling
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $surahTableUzb");
    await db.execute("DROP TABLE IF EXISTS $surahTableRus");
    await db.execute("DROP TABLE IF EXISTS $oyatTable");
    await db.execute("DROP TABLE IF EXISTS $oyatTableRus");
    await db.execute(
      'CREATE TABLE $surahTableUzb(id INTEGER PRIMARY KEY ,sura_id TEXT ,sura_name_arabic TEXT, name TEXT, sura_verse_count INTEGER,sura_from INTEGER )',
    );
    await db.execute(
      'CREATE TABLE $surahTableRus(id INTEGER PRIMARY KEY ,sura_id TEXT ,sura_name_arabic TEXT, name TEXT, sura_verse_count INTEGER,sura_from INTEGER )',
    );
    await db.execute(
      'CREATE TABLE $oyatTable (id INTEGER PRIMARY KEY, verse_id INTEGER,sura_number INTEGER,verse_number INTEGER,juz_number INTEGER,sura_id INTEGER,verse_arabic TEXT,text TEXT,meaning TEXT,verse_create_at TEXT,isSaved INTEGER,isReaded INTEGER)',
    );
    await db.execute(
      'CREATE TABLE $oyatTableRus (id INTEGER PRIMARY KEY, verse_id INTEGER,sura_number INTEGER,verse_number INTEGER,juz_number INTEGER,sura_id INTEGER,verse_arabic TEXT,text TEXT,meaning TEXT,verse_create_at TEXT,isSaved INTEGER,isReaded INTEGER)',
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $surahTableUzb(id INTEGER PRIMARY KEY ,sura_id TEXT ,sura_name_arabic TEXT, name TEXT, sura_verse_count INTEGER,sura_from INTEGER )',
    );
    debugPrint("salom");
    await db.execute(
      'CREATE TABLE $surahTableRus(id INTEGER PRIMARY KEY ,sura_id TEXT ,sura_name_arabic TEXT, name TEXT, sura_verse_count INTEGER,sura_from INTEGER )',
    );
    await db.execute(
      'CREATE TABLE $oyatTable (id INTEGER PRIMARY KEY, verse_id TEXT,sura_number INTEGER,verse_number INTEGER,juz_number INTEGER,sura_id INTEGER,verse_arabic TEXT,text TEXT,meaning TEXT,verse_create_at TEXT,isSaved INTEGER,isReaded INTEGER)',
    );
    await db.execute(
      'CREATE TABLE $oyatTableRus (id INTEGER PRIMARY KEY, verse_id TEXT,sura_number INTEGER,verse_number INTEGER,juz_number INTEGER,sura_id INTEGER,verse_arabic TEXT,text TEXT,meaning TEXT,verse_create_at TEXT,isSaved INTEGER,isReaded INTEGER)',
    );
  }

  /// quron /////////////////////////////////////////
  Future<void> insertQuron(QuronModel quronModel) async {
    final db = await _quronDBService.database;
    try {
      await db.transaction((txn) async {
        var result = await txn.query(
          getSurahTable(),
          where: 'sura_id = ?',
          whereArgs: [quronModel.suraId],
        );

        if (result.isEmpty) {
          // No existing data, insert new row
          await txn.insert(
            getSurahTable(),
            {
              "sura_id": quronModel.suraId,
              "sura_name_arabic": quronModel.suraNameArabic,
              "name": quronModel.name,
              "sura_verse_count": quronModel.suraVerseCount,
              "sura_from": quronModel.suraFrom,
            },
          );
        } else {
          // Data already exists, update the row
          await txn.update(
            getSurahTable(),
            {
              "sura_id": quronModel.suraId,
              "sura_name_arabic": quronModel.suraNameArabic,
              "name": quronModel.name,
              "sura_verse_count": quronModel.suraVerseCount,
              "sura_from": quronModel.suraFrom,
            },
            where: 'sura_id = ?',
            whereArgs: [quronModel.suraId],
          );
        }
      });
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
    debugPrint("${getSurahTable().length} quron table length from insert");
  }

  Future<List<QuronModel>?> getQuron() async {
    final db = await _quronDBService.database;
    // await clearDatabase();
    final List<Map<String, dynamic>> maps = await db.query(getSurahTable());
    debugPrint("${maps.length} data length from db");
    return List.generate(maps.length, (i) {
      return QuronModel(
          suraNameArabic: maps[i]['sura_name_arabic'],
          name: maps[i]['name'],
          suraVerseCount: maps[i]['sura_verse_count'],
          suraFrom: maps[i]['sura_from'],
          suraId: maps[i]['sura_id']);
    });
  }

  /* //////////////////// /////////////////////////// Oyat DB */

  Future<void> insertOyatList(OyatModel oyatList) async {
    final db = await _quronDBService.database;

    try {
      await db.transaction((txn) async {
        var result = await txn.query(getOyatTable(),
            where: 'verse_id = ?', whereArgs: [oyatList.verseId]);

        if (result.isEmpty) {
          // No existing data, insert new row
          await txn.insert(
            getOyatTable(),
            oyatList.toJson(),
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        } else {
          // Data already exists, update the row
          await txn.update(
            getOyatTable(),
            oyatList.toJson(),
            where: 'verse_id = ?',
            whereArgs: [oyatList.verseId],
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }
      });
      debugPrint('Oyat list inserted successfully');
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
  }

  Future<List<OyatModel>?> getOyatById(int suraId) async {
    final db = await _quronDBService.database;
    try {
      debugPrint(suraId.toString());
      final List<Map<String, dynamic>> maps = await db
          .query(getOyatTable(), where: 'sura_id = ?', whereArgs: [suraId]);
      debugPrint("$maps DATA FROM DB IS GET OYAT BY ID");

      if (maps.isNotEmpty) {
        // debugPrint("$maps is not empty maps");

        // If data is found, convert the maps to a list of OyatModel objects
        return List.generate(maps.length, (i) {
          debugPrint(maps[i]['isReaded'].toString());
          debugPrint(maps[i]['isSaved'].toString());
          return OyatModel.fromJson(maps[i]);
        });
      } else {
        // If no data is found, return an empty list
        debugPrint("No item found in the database with sura_id $suraId");
        return [];
      }
    } on DatabaseException catch (e) {
      // Handle any database exceptions
      debugPrint("${e.toString()} database Exception");
      return null;
    }
  }

  Future<List<OyatModel>?> getOyatJuzById(int juzNumber) async {
    final db = await _quronDBService.database;
    try {
      debugPrint(juzNumber.toString());
      final List<Map<String, dynamic>> maps = await db.query(getOyatTable(),
          where: 'juz_number = ?',
          orderBy: juzNumber == 1 ? null : 'verse_id ASC',
          whereArgs: [juzNumber]);
      debugPrint("$maps DATA FROM DB IS GET OYAT BY ID");

      if (maps.isNotEmpty) {
        debugPrint("$maps is not empty maps");

        // If data is found, convert the maps to a list of OyatModel objects
        return List.generate(maps.length, (i) {
          debugPrint(maps[i]['isReaded'].toString());
          debugPrint(maps[i]['isSaved'].toString());
          return OyatModel.fromJson(maps[i]);
        });
      } else {
        // If no data is found, return an empty list
        debugPrint("No item found in the database with juzNumber $juzNumber");
        return [];
      }
    } on DatabaseException catch (e) {
      // Handle any database exceptions
      debugPrint("${e.toString()} database Exception");
      return null;
    }
  }

  Future<void> updateReaded(int verseNumber, bool isReaded) async {
    final db = await _quronDBService.database;
    try {
      await db.transaction((txn) async {
        // transation is used to for db is working well
        await txn.update(getOyatTable(), {"isReaded": isReaded ? 1 : 0},
            where: 'verse_id = ?',
            whereArgs: [verseNumber],
            conflictAlgorithm: ConflictAlgorithm.replace);
      });
      debugPrint('readed save successfully');
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
  }

  Future<void> updateSaved(int verseNumber, bool isSaved) async {
    final db = await _quronDBService.database;
    try {
      await db.transaction((txn) async {
        // transation is used to for db is working well
        await txn.update(getOyatTable(), {"isSaved": isSaved ? 1 : 0},
            where: 'verse_id = ?',
            whereArgs: [verseNumber],
            conflictAlgorithm: ConflictAlgorithm.replace);

        debugPrint('saved save successfully');
      });
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
  }

  Future<List<OyatModel>?> getSavedOyats() async {
    final db = await _quronDBService.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        getOyatTable(),
        where: 'isSaved = ?',
        whereArgs: [1],
      );
      debugPrint("$maps DATA FROM DB IS GET OYATByJuz BY ID");

      if (maps.isNotEmpty) {
        debugPrint("$maps is not empty maps");

        return List.generate(maps.length, (i) {
          return OyatModel.fromJson(maps[i]);
        });
      } else {
        return [];
      }
    } on DatabaseException catch (e) {
      // Handle any database exceptions
      debugPrint("${e.toString()} database Exception");
      return null;
    }
  }

  Future<List<OyatModel>?> getAllOyat() async {
    final db = await _quronDBService.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(getOyatTable());
      debugPrint("$maps DATA FROM DB IS GET ALL OYAT");
      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return OyatModel.fromJson(maps[i]);
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

  Future<void> clearDatabases() async {
    final db = await _quronDBService.database;
    // await db.delete(surahTableUzb);
    // await db.delete(surahTableRus);
    await db.delete(oyatTable);
    debugPrint('Oyat db cleared successfully');
    debugPrint('quron db cleared successfully');
  }
}
