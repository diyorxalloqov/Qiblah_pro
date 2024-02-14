import 'package:path/path.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesDbService {
  static final NamesDbService _namesDBService = NamesDbService._internal();

  factory NamesDbService() => _namesDBService;

  NamesDbService._internal();

  static String namesTable = 'names';

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
      version: 2,
      onUpgrade: _onUpgrade,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $namesTable");
    await db.execute(
      'CREATE TABLE $namesTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name_arabic TEXT,name_audio_link TEXT, title TEXT, description TEXT, translation TEXT)',
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // user
    await db.execute(
      'CREATE TABLE $namesTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name_arabic TEXT, name_audio_link TEXT, title TEXT, description TEXT, translation TEXT)',
    );
  }

  /// user

  Future<void> insertNames(NamesData namesModel) async {
    final db = await _namesDBService.database;
    try {
      await db.insert(
        namesTable,
        {
          "name_arabic": namesModel.nameArabic,
          "title": namesModel.title,
          "description": namesModel.description,
          "translation": namesModel.translation,
          "name_audio_link": namesModel.nameAudioLink
        },
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    } on DatabaseException catch (e) {
      print("${e.toString()} database Exception");
    }
    print("${namesTable.length} names table length from insert");
  }

  Future<List<NamesData>?> getNames() async {
    final db = await _namesDBService.database;
    // await clearDatabase();
    final List<Map<String, dynamic>> maps = await db.query(namesTable);
    print("${maps.length} data length from db");
    return List.generate(maps.length, (i) {
      return NamesData(
          nameArabic: maps[i]['name_arabic'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          translation: maps[i]['translation'],
          nameAudioLink: maps[i]['name_audio_link']);
    });
  }

  Future<void> clearDatabase() async {
    final db = await _namesDBService.database;
    await db.delete(namesTable);
    print('db cleared successfully');
  }
}
