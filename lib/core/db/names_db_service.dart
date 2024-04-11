import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesDbService {
  static final NamesDbService _namesDBService = NamesDbService._internal();

  factory NamesDbService() => _namesDBService;

  NamesDbService._internal();

  static String getNamesTable() {
    final lang = StorageRepository.getString(Keys.lang);
    debugPrint(lang.toString());
    return lang == 'uz' ? namesTableUzb : namesTableRus;
  }

  static String namesTableRus = 'namesRus';
  static String namesTableUzb = "namesUzb";

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'names.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $namesTableUzb");
    await db.execute("DROP TABLE IF EXISTS $namesTableRus");
    await db.execute(
      'CREATE TABLE $namesTableUzb (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name_arabic TEXT, name_audio_link TEXT, title TEXT, description TEXT, translation TEXT)',
    );
    await db.execute(
      'CREATE TABLE $namesTableRus (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name_arabic TEXT, name_audio_link TEXT, title TEXT, description TEXT, translation TEXT)',
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    debugPrint(getNamesTable().toString());
    // user
    await db.execute(
      'CREATE TABLE $namesTableUzb (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name_arabic TEXT, name_audio_link TEXT, title TEXT, description TEXT, translation TEXT)',
    );
    await db.execute(
      'CREATE TABLE $namesTableRus (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name_arabic TEXT, name_audio_link TEXT, title TEXT, description TEXT, translation TEXT)',
    );
  }

  /// user
  Future<void> insertNames(NamesData namesModel) async {
    final db = await _namesDBService.database;

    try {
      await db.insert(
        getNamesTable(),
        {
          "name_arabic": namesModel.nameArabic,
          "title": namesModel.title,
          "description": namesModel.description,
          "translation": namesModel.translation,
          "name_audio_link": namesModel.nameAudioLink
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on DatabaseException catch (e) {
      debugPrint("${e.toString()} database Exception");
    }
    debugPrint("${getNamesTable()} names table length from insert");
  }

  Future<List<NamesData>?> getNames() async {
    final db = await _namesDBService.database;
    final List<Map<String, dynamic>> maps = await db.query(getNamesTable());
    debugPrint("${maps.length} data length from db");
    return List.generate(maps.length, (i) {
      return NamesData(
        nameArabic: maps[i]['name_arabic'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        translation: maps[i]['translation'],
        nameAudioLink: maps[i]['name_audio_link'],
        nameId: maps[i]['id'].toString(),
      );
    });
  }

  Future<void> updateNames(NamesData namesModel) async {
    final db = await _namesDBService.database;

    /* 
    
    serverdan kegan version bilan tekshirish kerak

     */

    await db.update(
      getNamesTable(),
      {
        "name_arabic": namesModel.nameArabic,
        "title": namesModel.title,
        "description": namesModel.description,
        "translation": namesModel.translation,
        "name_audio_link": namesModel.nameAudioLink
      },
      where: 'id = ?',
      whereArgs: [namesModel.nameId],
    );
  }

  Future<void> clearDatabase() async {
    final db = await _namesDBService.database;
    await db.delete(namesTableRus);
    await db.delete(namesTableUzb);
    debugPrint('db cleared successfully');
  }
}
