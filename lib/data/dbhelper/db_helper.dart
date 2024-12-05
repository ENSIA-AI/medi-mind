import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/utils/dates.dart';
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
    String path = join(await getDatabasesPath(), 'medication.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reminders (
        id TEXT PRIMARY KEY,
        name TEXT,
        dosage TEXT,
        frequency INTEGER,
        form TEXT,
        imagePath TEXT,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE intakes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        reminderId TEXT,
        time TEXT,
        dose INTEGER,
        FOREIGN KEY (reminderId) REFERENCES reminders (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        intakeId INTEGER,
        date TEXT,
        status INTEGER,  -- 1 = Done, 0 = Missed, NULL = Pending
        FOREIGN KEY (intakeId) REFERENCES intakes (id)
      )
    ''');
  }

  
  Future<void> insertReminder(Reminder reminder) async {
    final db = await database;

    // Insert the reminder
    await db.insert('reminders', {
      'id': reminder.id,
      'name': reminder.name,
      
      'frequency': reminder.frequency,
      'form': reminder.form,
      'imagePath': reminder.imageUrl,
      
    });

    // Insert intakes
    for (final intake in reminder.intakes) {
      await db.insert('intakes', {
        'reminderId': reminder.id,
        'time': intake.time.format24Hour(), // Assuming helper for TimeOfDay formatting
        'dose': intake.dose,
      });
    }
  }

  
  // Future<void> markIntakeAsDone(int intakeId, String date) async {
  //   final db = await database;
    
  //   await db.insert('progress', {
  //     'intakeId': intakeId,
  //     'date': date,
  //     'status': 1  // 1 represents "Done"
  //   }, conflictAlgorithm: ConflictAlgorithm.replace); // Replaces existing progress if any
  // }
  
  
  // Future<void> markIntakeAsMissed(int intakeId, String date) async {
  //   final db = await database;
     
  //   await db.insert('progress', {
  //     'intakeId': intakeId,
  //     'date': date,
  //     'status': 0  // 0 represents "Missed"
  //   }, conflictAlgorithm: ConflictAlgorithm.replace);  // Replaces existing progress if any
  // }

  
  // Future<double> getCompletionPercentage(String reminderId, String date) async {
  //   final db = await database;
    
  //   final result = await db.rawQuery('''
  //     SELECT 
  //       COUNT(CASE WHEN p.status = 1 THEN 1 END) * 100.0 / COUNT(*) AS completionPercentage
  //     FROM intakes i
  //     LEFT JOIN progress p ON i.id = p.intakeId AND p.date = ?
  //     WHERE i.reminderId = ?
  //   ''', [date, reminderId]);

  //   return result.isNotEmpty ? result.first['completionPercentage'] as Double : 0.0;
  // }

  
  // Future<List<Map<String, dynamic>>> getMissedIntakes(String reminderId, String date) async {
  //   final db = await database;
    
  //   final result = await db.query(
  //     'intakes i',
  //     columns: ['i.id AS intakeId', 'i.time'],
  //     where: 'i.reminderId = ?',
  //     whereArgs: [reminderId],
  //     leftJoin: 'LEFT JOIN progress p ON i.id = p.intakeId AND p.date = ?',
  //     whereArgs: [date],
  //     where: 'p.status IS NULL OR p.status = 0', // Missed if status is NULL or 0
  //   );

  //   return result;
  // }

  
  // Future<List<Map<String, dynamic>>> getAllRemindersProgress(String date) async {
  //   final db = await database;
    
  //   final result = await db.rawQuery('''
  //     SELECT 
  //       r.id AS reminderId,
  //       r.name,
  //       p.date,
  //       COUNT(CASE WHEN p.status = 1 THEN 1 END) * 100.0 / COUNT(i.id) AS completionPercentage
  //     FROM reminders r
  //     LEFT JOIN intakes i ON r.id = i.reminderId
  //     LEFT JOIN progress p ON i.id = p.intakeId
  //     WHERE p.date = ?
  //     GROUP BY r.id, p.date
  //   ''', [date]);

  //   return result;
  // }
  
  // Optional: Delete reminder and associated progress (cascade delete)
  // Future<void> deleteReminder(String reminderId) async {
  //   final db = await database;

  //   // Delete progress records for this reminder
  //   await db.delete('progress', where: 'intakeId IN (SELECT id FROM intakes WHERE reminderId = ?)', whereArgs: [reminderId]);

  //   // Delete the intakes for this reminder
  //   await db.delete('intakes', where: 'reminderId = ?', whereArgs: [reminderId]);

  //   // Delete the reminder itself
  //   await db.delete('reminders', where: 'id = ?', whereArgs: [reminderId]);
  // }
}
