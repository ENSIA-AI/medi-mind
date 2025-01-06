import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';

class ScheduleState {
  final DateTime selectedMonth;
  final DateTime selectedDate;
  final List<Map<String, dynamic>> reminders;

  ScheduleState({
    required this.selectedMonth,
    required this.selectedDate,
    required this.reminders,
  });

  ScheduleState copyWith({
    DateTime? selectedMonth,
    DateTime? selectedDate,
    List<Map<String, dynamic>>? reminders,
  }) {
    return ScheduleState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      reminders: reminders ?? this.reminders,
    );
  }
}

class ScheduleCubit extends Cubit<ScheduleState> {
  final DbHelper _dbHelper;

  ScheduleCubit(this._dbHelper)
      : super(ScheduleState(
          selectedMonth: DateTime(DateTime.now().year, DateTime.now().month),
          selectedDate: DateTime.now(),
          reminders: [],
        )) {
    fetchReminders();
  }

  Future<void> fetchReminders() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> remindersData = await db.rawQuery('''
      SELECT intakes.id, intakes.medicationId, intakes.time, intakes.dose, 
             medications.name, medications.unit, medications.img, medications.details, medications.reminderDays
      FROM intakes
      JOIN medications ON intakes.medicationId = medications.id
    ''');

    final reminders = remindersData.where((reminder) {
      int reminderDaysBinary = reminder['reminderDays'];
      int selectedDayBit = 1 << (state.selectedDate.weekday - 1);
      return (reminderDaysBinary & selectedDayBit) != 0;
    }).toList();

    emit(state.copyWith(reminders: reminders));
  }

  void updateSelectedDay(int value) {
    final updatedDate = state.selectedDate.copyWith(day: value);
    emit(state.copyWith(selectedDate: updatedDate));
    fetchReminders();
  }

  void updateSelectedMonth(DateTime? value) {
    if (value != null) {
      final updatedDate = state.selectedDate.copyWith(
        year: value.year,
        month: value.month,
      );
      emit(state.copyWith(selectedMonth: value, selectedDate: updatedDate));
      fetchReminders();
    }
  }

  List<DateTime> generateMonthYearList() {
    final currentYear = DateTime.now().year;
    final startYear = currentYear;
    final endYear = currentYear + 2;

    List<DateTime> monthYearList = [];
    for (int year = startYear; year <= endYear; year++) {
      for (int month = 1; month <= 12; month++) {
        monthYearList.add(DateTime(year, month));
      }
    }
    return monthYearList;
  }
}
