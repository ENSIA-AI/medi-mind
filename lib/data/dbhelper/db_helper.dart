import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;

  DbHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'medimind.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        unit TEXT NOT NULL,
        img BLOB,
        details TEXT,
        startDate TEXT NOT NULL,
        endDate TEXT,
        reminderDays INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE intakes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        medicationId INTEGER,
        time TEXT,
        dose INTEGER,
        FOREIGN KEY (medicationId) REFERENCES medications (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        intakeId INTEGER,
        date TEXT,
        status INTEGER NOT NULL, -- 1 = Done, 0 = Skipped
        FOREIGN KEY (intakeId) REFERENCES intakes (id)
      )
    ''');
  }
}
