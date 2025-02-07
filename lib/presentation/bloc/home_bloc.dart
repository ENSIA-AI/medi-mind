import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/data/dbhelper/notificationDbHelper.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medi_mind/utils/toast_message.dart';

class HomeState {
  final DateTime currentTime;
  final List<Map<String, dynamic>> upcomingReminders;
  final List<double> weekProgress;

  HomeState({
    required this.currentTime,
    required this.upcomingReminders,
    required this.weekProgress,
  });

  HomeState copyWith({
    DateTime? currentTime,
    List<Map<String, dynamic>>? upcomingReminders,
    List<double>? weekProgress,
  }) {
    return HomeState(
      currentTime: currentTime ?? this.currentTime,
      upcomingReminders: upcomingReminders ?? this.upcomingReminders,
      weekProgress: weekProgress ?? this.weekProgress,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  final DbHelper _dbHelper;

  HomeCubit(this._dbHelper)
      : super(HomeState(
          currentTime: DateTime.now(),
          upcomingReminders: [],
          weekProgress: List.filled(7, 0.0),
        )) {
    fetchUpcomingReminders();
    calculateWeekProgress();
  }

  Future<void> fetchUpcomingReminders() async {
    final db = await _dbHelper.database;
    final now = DateTime.now();
    // Adjust weekday to make Monday = 0 (subtract 1 from weekday and use modulo 7)
    final currentDayBit = 1 << ((now.weekday - 1) % 7);
    final currentTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    // Query medications and intakes for today that haven't been marked as taken
    final remindersData = await db.rawQuery('''
      SELECT 
        m.id AS medicationId,
        m.name,
        m.unit,
        m.img,
        m.details,
        m.reminderDays,
        i.id AS intakeId,
        i.time,
        i.dose
      FROM medications m
      JOIN intakes i ON m.id = i.medicationId
      LEFT JOIN progress p ON i.id = p.intakeId AND date(p.date) = date(?)
      WHERE (m.reminderDays & ?) != 0
        AND p.id IS NULL
        AND i.time >= ?
      ORDER BY i.time
    ''', [now.toIso8601String(), currentDayBit, currentTime]);

    emit(state.copyWith(upcomingReminders: remindersData));
  }

  List<int> _decodeDays(int reminderDaysBinary) {
    List<int> selectedDays = [];
    for (int i = 0; i < 7; i++) {
      if ((reminderDaysBinary & (1 << i)) != 0) {
        selectedDays.add(i);
      }
    }
    return selectedDays;
  }

  Future<void> calculateWeekProgress() async {
    final db = await _dbHelper.database;
    final now = DateTime.now();
    List<double> weekProgress = List.filled(7, 0.0);

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateStr = date.toIso8601String().split('T')[0];
      // Adjust weekday to make Monday = 0
      final dayBit = 1 << ((date.weekday - 1) % 7);

      // Get total reminders for that day
      final totalReminders = Sqflite.firstIntValue(await db.rawQuery('''
        SELECT COUNT(*) FROM intakes i
        JOIN medications m ON i.medicationId = m.id
        WHERE (m.reminderDays & ?) != 0
      ''', [dayBit])) ?? 0;

      // Get completed reminders
      final completedReminders = Sqflite.firstIntValue(await db.rawQuery('''
        SELECT COUNT(*) FROM progress p
        JOIN intakes i ON p.intakeId = i.id
        JOIN medications m ON i.medicationId = m.id
        WHERE date(p.date) = ? AND p.status = 1
      ''', [dateStr])) ?? 0;

      double progress =
          totalReminders > 0 ? completedReminders / totalReminders : 0.0;
      weekProgress[6 - i] = progress;
    }

    emit(state.copyWith(weekProgress: weekProgress));
  }

  Future<void> markReminderAsTaken(int intakeId) async {
    final db = await _dbHelper.database;
    final now = DateTime.now();

    await db.insert('progress', {
      'intakeId': intakeId,
      'date': now.toIso8601String(),
      'status': 1,
    });
     await markReminderAsDone(
        intakeId: intakeId, nowdate: now.toIso8601String());
    ShowToastMessage("Reminder marked as taken!");
    await calculateWeekProgress();
    await fetchUpcomingReminders();
  }
}
