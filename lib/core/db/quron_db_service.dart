import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/quron_model.dart';

class QuronDBService {
  static final QuronDBService _quronDBService = QuronDBService._internal();

  factory QuronDBService() => _quronDBService;

  QuronDBService._internal();

  static String getSurahTable() {
    final lang = StorageRepository.getString(Keys.lang);
    return lang == 'uz' ? surahTableUzb : surahTableRus;
  }

  static String surahTableUzb = "surahUzb";
  static String surahTableRus = 'surahRus';

  // static String oyatTable = 'oyat';

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
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $surahTableUzb");
    await db.execute("DROP TABLE IF EXISTS $surahTableRus");
    await db.execute(
      'CREATE TABLE $surahTableUzb(sura_id TEXT ,sura_name_arabic TEXT, name TEXT, sura_verse_count INTEGER,sura_from INTEGER )',
    );
    await db.execute(
      'CREATE TABLE $surahTableRus(sura_id TEXT ,sura_name_arabic TEXT, name TEXT, sura_verse_count INTEGER,sura_from INTEGER )',
    );
    // await db.execute(
    //   'CREATE TABLE IF NOT EXISTS $oyatTable (id INTEGER PRIMARY KEY,verse_id TEXT,sura_number INTEGER,verse_number INTEGER,juz_number INTEGER,sura_id INTEGER,verse_arabic TEXT,text TEXT,meaning TEXT,verse_create_at TEXT)',
    // );
  }

  Future<void> _onCreate(Database db, int version) async {
    // quron
    print(getSurahTable());
    await db.execute(
      'CREATE TABLE $surahTableUzb(sura_id TEXT ,sura_name_arabic TEXT, name TEXT, sura_verse_count INTEGER,sura_from INTEGER )',
    );
    await db.execute(
      'CREATE TABLE $surahTableRus(sura_id TEXT ,sura_name_arabic TEXT, name TEXT, sura_verse_count INTEGER,sura_from INTEGER )',
    );
    // await db.execute(
    //   'CREATE TABLE IF NOT EXISTS $oyatTable (id INTEGER PRIMARY KEY, verse_id TEXT,sura_number INTEGER,verse_number INTEGER,juz_number INTEGER,sura_id INTEGER,verse_arabic TEXT,text TEXT,meaning TEXT,verse_create_at TEXT)',
    // );
  }

  /// quron /////////////////////////////////////////

  Future<void> insertQuron(QuronModel quronModel) async {
    final db = await _quronDBService.database;
    try {
      await db.insert(
          getSurahTable(),
          {
            "sura_id": quronModel.suraId,
            "sura_name_arabic": quronModel.suraNameArabic,
            "name": quronModel.name,
            "sura_verse_count": quronModel.suraVerseCount,
            "sura_from": quronModel.suraFrom,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    } on DatabaseException catch (e) {
      print("${e.toString()} database Exception");
    }
    print("${getSurahTable().length} quron table length from insert");
  }

  Future<List<QuronModel>?> getQuron() async {
    final db = await _quronDBService.database;
    // await clearDatabase();
    final List<Map<String, dynamic>> maps = await db.query(getSurahTable());
    print("${maps.length} data length from db");
    return List.generate(maps.length, (i) {
      return QuronModel(
          suraNameArabic: maps[i]['sura_name_arabic'],
          name: maps[i]['name'],
          suraVerseCount: maps[i]['sura_verse_count'],
          suraFrom: maps[i]['sura_from'],
          suraId: maps[i]['sura_id']);
    });
  }

  Future<void> updateQuron(QuronModel quronModel) async {
    final db = await _quronDBService.database;
    /* 
    
    serverdan kegan version bilan tekshirish kerak

     */
    await db.update(
      getSurahTable(),
      {
        "sura_name_arabic": quronModel.suraNameArabic,
        "name": quronModel.name,
        "sura_verse_count": quronModel.suraVerseCount,
        "sura_from": quronModel.suraFrom,
      },
      where: 'id = ?',
      whereArgs: [quronModel.suraId],
    );
  }

  /* //////////////////// Oyat DB */

  // Future<void> insertOyatList(List<OyatModel> oyatList) async {
  //   final db = await _quronDBService.database;

  //   try {
  //     for (var oyat in oyatList) {
  //       await db.insert(
  //         oyatTable,
  //         {
  //           "verse_id": oyat.verseId,
  //           "sura_number": oyat.suraNumber,
  //           "verse_number": oyat.verseNumber,
  //           "juz_number": oyat.juzNumber,
  //           "sura_id": oyat.suraId,
  //           "verse_arabic": oyat.verseArabic,
  //           "text": oyat.text,
  //           "meaning": oyat.meaning,
  //         },
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //       );
  //     }
  //     print('Oyat list inserted successfully');
  //   } on DatabaseException catch (e) {
  //     print("${e.toString()} database Exception");
  //   }
  // }

  // Future<List<OyatModel>?> getOyatById(int suraId) async {
  //   final db = await _quronDBService.database;
  //   try {
  //     final List<Map<String, dynamic>> maps = await db.query(
  //       oyatTable,
  //       where: 'sura_id = ?',
  //       whereArgs: [suraId],
  //     );

  //     if (maps.isNotEmpty) {
  //       // If data is found, convert the maps to a list of OyatModel objects
  //       return List.generate(maps.length, (i) {
  //         return OyatModel(
  //           id: maps[i]['id'],
  //           verseId: maps[i]['verse_id'],
  //           suraNumber: maps[i]['sura_number'],
  //           verseNumber: maps[i]['verse_number'],
  //           juzNumber: maps[i]['juz_number'],
  //           suraId: maps[i]['sura_id'],
  //           verseArabic: maps[i]['verse_arabic'],
  //           text: maps[i]['text'],
  //           meaning: maps[i]['meaning'],
  //         );
  //       });
  //     } else {
  //       // If no data is found, return an empty list
  //       print("No item found in the database with sura_id $suraId");
  //       return [];
  //     }
  //   } on DatabaseException catch (e) {
  //     // Handle any database exceptions
  //     print("${e.toString()} database Exception");
  //     return null;
  //   }
  // }

/*

Future<void> updateOyat(OyatModel oyatModel) async {
  final db = await _quronDBService.database;
  await db.update(
    oyatTable,
    oyatModel.toJson(),
    where: 'id = ?',
    whereArgs: [oyatModel.id], // Assuming 'id' is the primary key of oyatModel
  );
}
 */

  // Future<void> updateOyat(OyatModel oyatModel) async {
  //   final db = await _quronDBService.database;
  //   /*

  //   serverdan kegan version bilan tekshirish kerak

  //    */
  //   await db.update(
  //     surahTable,
  //     oyatModel.toJson(),
  //     where: 'id = ?',
  //     whereArgs: [oyatModel.suraId],
  //   );
  // }

  Future<void> clearDatabases() async {
    final db = await _quronDBService.database;
    await db.delete(surahTableUzb);
    await db.delete(surahTableRus);
    // await db.delete(oyatTable);
    print('Oyat db cleared successfully');
    print('db cleared successfully');
  }
}
