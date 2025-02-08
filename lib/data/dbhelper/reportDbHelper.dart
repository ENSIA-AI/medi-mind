import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart'; 

// weekly progress
Future<List<double>> getWeeklyProgress() async {
  final db = await DbHelper().database;
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  
  DateTime sunday =
      now.subtract(Duration(days: now.weekday)); 

  
  List<String> weekDates = List.generate(7, (index) {
    DateTime day = sunday.add(Duration(days: index));
    return formatter.format(day);
  }).toList();

  List<double> progressList = [];

 
  for (int i = 0; i < weekDates.length; i++) {
    String date = weekDates[i];

    
    if (DateTime.parse(date).isAfter(now)) {
      progressList.add(0.0); 
      continue;
    }

    int dayBit = 1 << (DateTime.parse(date).weekday - 1);

    final totalReminders = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT COUNT(*) FROM intakes i
      JOIN medications m ON i.medicationId = m.id
      WHERE (m.reminderDays & ?) != 0
    ''', [dayBit])) ?? 0;

    final completedReminders = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT COUNT(*) FROM progress p
      JOIN intakes i ON p.intakeId = i.id
      JOIN medications m ON i.medicationId = m.id
      WHERE date(p.date) = ? AND p.status = 1
    ''', [date])) ?? 0;

    double progress =
        totalReminders > 0 ? (completedReminders / totalReminders) * 100 : 0.0;

    progressList.add(double.parse(progress.toStringAsFixed(2)));
  }
  return progressList;
}

// today progress
Future<double> getTodayProgress() async {
  final db = await DbHelper().database;
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  String date = formatter.format(now);

  
  int dayBit = 1 << (now.weekday - 1);

  final totalReminders = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM intakes i
    JOIN medications m ON i.medicationId = m.id
    WHERE (m.reminderDays & ?) != 0
  ''', [dayBit])) ?? 0;

  final completedReminders = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM progress p
    JOIN intakes i ON p.intakeId = i.id
    JOIN medications m ON i.medicationId = m.id
    WHERE date(p.date) = ? AND p.status = 1
  ''', [date])) ?? 0;

  double progress =
      totalReminders > 0 ? completedReminders / totalReminders : 0.0;

 
  return double.parse(progress.toStringAsFixed(2));
}

// Month progression
Future<double> getMonthProgress() async {
  final db = await DbHelper().database;
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  String today = formatter.format(now);
  String firstDayOfMonthStr =
      formatter.format(DateTime(now.year, now.month, 1));

  
  final int totalReminders = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT COUNT(*)
      FROM intakes i
      JOIN medications m ON i.medicationId = m.id
    ''')) ?? 0;

 
  final int totalDays = now.day;
  final int expectedReminders = totalReminders * totalDays;

  
  final int completedReminders = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT COUNT(*)
      FROM progress p
      JOIN intakes i ON p.intakeId = i.id
      WHERE substr(p.date, 1, 10) BETWEEN ? AND ? AND p.status = 1
    ''', [firstDayOfMonthStr, today])) ?? 0;

 
  double progress =
      expectedReminders > 0 ? completedReminders / expectedReminders : 0.0;

  return double.parse(progress.toStringAsFixed(2));
}

// calculate the missed values over the year
Future<List<int>> getMonthlyMissedIntakes() async {
  final db = await DbHelper().database;
  final DateTime now = DateTime.now();
  final String currentTime =
      DateFormat('HH:mm').format(now); 
  List<int> missedIntakesList =
      List.filled(12, 0); 

  for (int month = 1; month <= 12; month++) {
    String monthStart =
        DateFormat('yyyy-MM-dd').format(DateTime(now.year, month, 1));
    String monthEnd = DateFormat('yyyy-MM-dd').format(DateTime(now.year, month,
        (month == now.month) ? now.day : DateTime(now.year, month + 1, 0).day));

    if (now.month >= month) {
      
      final List<Map<String, dynamic>> medicationRecords = await db.rawQuery(
          '''
        SELECT m.startDate, m.endDate, i.time, COUNT(i.id) AS intakeCount 
        FROM intakes i
        JOIN medications m ON i.medicationId = m.id
        WHERE date(m.startDate) <= ? 
          AND (m.endDate IS NULL OR date(m.endDate) >= ?)
          ${month == now.month ? "AND i.time <= ?" : ""}
        GROUP BY m.id, i.time
      ''',
          month == now.month
              ? [monthEnd, monthStart, currentTime]
              : [monthEnd, monthStart]);

      int totalReminders = 0;
      for (var record in medicationRecords) {
        DateTime medStartDate = DateTime.parse(record['startDate']);
        int intakeCountPerDay = record['intakeCount'];

        
        DateTime effectiveStartDate =
            (medStartDate.isBefore(DateTime(now.year, month, 1)))
                ? DateTime(now.year, month, 1)
                : medStartDate;

        int totalDaysForMed = (now.month == month)
            ? now.day - effectiveStartDate.day + 1
            : DateTime(now.year, month + 1, 0).day - effectiveStartDate.day + 1;

        totalReminders += intakeCountPerDay * totalDaysForMed;
      }

      
      final int completedIntakes = Sqflite.firstIntValue(await db.rawQuery('''
        SELECT COUNT(*) FROM progress p
        JOIN intakes i ON p.intakeId = i.id
        WHERE p.status = 1 
          AND date(p.date) BETWEEN ? AND ?
      ''', [monthStart, monthEnd])) ?? 0;

      
      missedIntakesList[month - 1] =
          (totalReminders - completedIntakes).clamp(0, 8);
    }
  }

  return missedIntakesList;
}

// weekly progress for each medication
Future<List<Map<String, dynamic>>> getMedicationsWeeklyProgress() async {
  final db = await DbHelper().database;
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

 
  DateTime sunday = now.subtract(Duration(days: now.weekday - 1));

  
  List<String> weekDates = List.generate(7, (index) {
    DateTime day = sunday.add(Duration(days: index));
    return formatter.format(day);
  }).toList();

  
  List<Map<String, dynamic>> medications = await db.rawQuery('''
    SELECT m.id, m.name, m.unit, i.dose, m.startDate, m.endDate, m.reminderDays 
    FROM medications m
    LEFT JOIN intakes i ON m.id = i.medicationId
    GROUP BY m.id
  ''');

  List<Map<String, dynamic>> medicationProgressList = [];

 
  for (var medication in medications) {
    List<double> progressList = [];

    
    String medicationTitle =
        '${medication['name']}, ${medication['dose']} ${medication['unit']}';

    
    for (int i = 0; i < weekDates.length; i++) {
      String date = weekDates[i];

      
      if (DateTime.parse(date).isAfter(now)) {
        progressList.add(0.0); 
        continue;
      }

      
      int dayBit = 1 << (DateTime.parse(date).weekday - 1);

      // Get total reminders for this medication on the specific day
      final int totalReminders = Sqflite.firstIntValue(await db.rawQuery('''
        SELECT COUNT(*) FROM intakes i
        JOIN medications m ON i.medicationId = m.id
        WHERE (m.reminderDays & ?) != 0 
          AND m.id = ? 
          AND date(m.startDate) <= ? 
          AND (m.endDate IS NULL OR date(m.endDate) >= ?)
      ''', [dayBit, medication['id'], date, date])) ?? 0;

      
      final int completedReminders = Sqflite.firstIntValue(await db.rawQuery('''
        SELECT COUNT(*) FROM progress p
        JOIN intakes i ON p.intakeId = i.id
        WHERE date(p.date) = ? AND p.status = 1 AND i.medicationId = ?
      ''', [date, medication['id']])) ?? 0;

      
      double progress = totalReminders > 0
          ? (completedReminders / totalReminders) * 100
          : 0.0;

     
      progressList.add(double.parse(progress.toStringAsFixed(2)));
    }

    
    medicationProgressList.add({
      'medication': medicationTitle,
      'weeklyProgress': progressList,
    });
  }

  
  return medicationProgressList;
}
