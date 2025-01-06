import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';

import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/report_screen.dart';
import 'package:medi_mind/utils/toast_message.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class MedicationProvider extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int currentStep = 0;
  final medicationNameController = TextEditingController();
  Uint8List? image;
  Set<int> selectedDays = {};
  String? selectedUnit;
  int timesPerDay = 1;
  final List<IntakeData> intakeDataList =
      List.generate(6, (_) => IntakeData(time: TimeOfDay.now(), dose: 1));

  void updateImage(Uint8List? img) {
    image = img;
    notifyListeners();
  }

  void updateSelectedDays(Set<int> days) {
    selectedDays = days;
    notifyListeners();
  }

  void updateSelectedUnit(String? unit) {
    selectedUnit = unit;
    notifyListeners();
  }

  void updateTimesPerDay(int times) {
    timesPerDay = times;
    notifyListeners();
  }

  void updateIntakeData(int index, IntakeData data) {
    intakeDataList[index] = data;
    notifyListeners();
  }

  Future<bool> nextStep() async {
    if (currentStep < 3) {
      currentStep++;
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      notifyListeners();
      return true;
    } else {
      
      currentStep++;
      return await finish();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      notifyListeners();
    }
  }

  // Initialize a UUID generator

  Future<bool> finish() async {
    
    try {
      // 2. Prepare the medication data
      final dbHelper = DbHelper();
      final db = await dbHelper.database;
    

      Map<String, dynamic> medicationData = {
        'name': medicationNameController.text,
        'unit': selectedUnit!,
        'img': image ?? '',
        'details': '', // Add details field if needed
        'startDate':
            DateTime.now().toIso8601String(), // Assuming start date is now
        'endDate': null, // Modify as needed
        'reminderDays': constructReminderDays(selectedDays)
      };

      // 3. Insert medication into the database
      int medicationId = await db.insert('medications', medicationData);
      
      // 4. Insert intake data for the medication
      for (int i = 0; i < timesPerDay; i++) {
        final intake = intakeDataList[i];
        await db.insert('intakes', {
          'medicationId': medicationId,
          'time': formatTimeOfDay(intake.time),
          'dose': intake.dose,
        });
      }

      // 5. Success
      return true;
    } catch (e) {
      // 6. Handle errors
      print('Error saving medication: $e');
      currentStep--;
      return false;
    }
  }
}

String formatTimeOfDay(TimeOfDay time) {
  final String hour = time.hour.toString().padLeft(2, '0');
  final String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

int constructReminderDays(Set<int> days) {
  int reminderDays = 0;

  for (int day in days) {
    reminderDays |= (1 << day);
  }

  return reminderDays;
}
