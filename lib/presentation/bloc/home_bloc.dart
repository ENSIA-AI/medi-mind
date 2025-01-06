import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/reminder.dart';

class HomeState {
  final DateTime currentTime;
  final List<Map> upcomingReminders;

  HomeState({
    required this.currentTime,
    required this.upcomingReminders,
  });

  HomeState copyWith({
    DateTime? currentTime,
    List<Map>? upcomingReminders,
  }) {
    return HomeState(
      currentTime: currentTime ?? this.currentTime,
      upcomingReminders: upcomingReminders ?? this.upcomingReminders,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  final DbHelper _dbHelper;

  HomeCubit(this._dbHelper)
      : super(HomeState(currentTime: DateTime.now(), upcomingReminders: [])) {
    fetchUpcomingReminders();
  }

  Future<void> fetchUpcomingReminders() async {
    final db = await _dbHelper.database;

    // Query the database for intakes and associated medication details
    final remindersData = await db.rawQuery('''
      SELECT intakes.id AS intakeId, intakes.medicationId, intakes.time, intakes.dose, 
             medications.name, medications.unit, medications.img, medications.details, medications.reminderDays
      FROM intakes
      JOIN medications ON intakes.medicationId = medications.id
    ''');

    // Convert results into a list of maps
    final List<Map<String, dynamic>> intakeMaps = remindersData.map((data) {
      return {
        'intakeId': data['intakeId'],
        'medicationId': data['medicationId'],
        'time': data['time'],
        'dose': data['dose'],
        'medicationName': data['name'],
        'unit': data['unit'],
        'imageUrl': data['img'],
        'details': data['details'],
        'reminderDays': data['reminderDays'],
      };
    }).toList();

    // Filter intakes for today's reminders
    final today = DateTime.now().weekday - 1;
    final todayIntakes = intakeMaps.where((intake) {
      final reminderDays = intake['reminderDays'] as int;
      return _decodeDays(reminderDays).contains(today);
    }).toList();

    emit(state.copyWith(upcomingReminders: todayIntakes));
  }

  static List<int> _decodeDays(int reminderDaysBinary) {
    List<int> selectedDays = [];
    for (int i = 0; i < 7; i++) {
      if ((reminderDaysBinary & (1 << i)) != 0) {
        selectedDays.add(i);
      }
    }
    return selectedDays;
  }
}
