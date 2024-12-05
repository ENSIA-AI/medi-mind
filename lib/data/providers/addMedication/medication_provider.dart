import 'package:flutter/material.dart';

import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:uuid/uuid.dart';
class MedicationProvider extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int currentStep = 0;
  final medicationNameController = TextEditingController();
  String? imagePath;
  Set<int> selectedDays = {};
  String? selectedUnit;
  int timesPerDay = 1;
  final List<IntakeData> intakeDataList =
      List.generate(6, (_) => IntakeData(time: TimeOfDay.now(), dose: 1));


  void updateImagePath(String? path) {
    imagePath = path;
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

  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      notifyListeners();
    }
    else{
      print("object");
      finish();
    }
  }

  void previousStep() {
      if (currentStep > 0) {
      currentStep--;
      pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      notifyListeners();
    }
  }

  

// Initialize a UUID generator


void finish() async {
  var uuid = Uuid();
  
  
  if (medicationNameController.text.isEmpty || selectedUnit == null || selectedDays.isEmpty || imagePath == null) {
    // Show an error or return early if the data is incomplete
    return;
  }

  
  String reminderId = uuid.v4(); // Generate a UUIDv4
  
  
  // Create the reminder object
  Reminder reminder = Reminder(
    id: reminderId,  // Use UUIDv4 here
    name: medicationNameController.text,
    frequency: timesPerDay,
    form: selectedUnit ?? "Pill(s)",
    selectedDays: selectedDays.toList(),
    imageUrl: imagePath!, // Assuming image is selected
    intakes: List.generate(timesPerDay, (index) => IntakeData(
      time: intakeDataList[index].time,
      dose: intakeDataList[index].dose,
    )),
  );

  print((reminder.toJson()));
  // // 3. Save the reminder and its intakes to the database
  // await DbHelper().insertReminder(reminder);

  // // 4. Save the selected days (schedule) in a separate table if needed
  // for (var day in selectedDays) {
  //   // Insert each day and associate it with the reminder ID
  //   await DbHelper().(reminder.id, day);
  // }

  // 5. Optionally: Show a confirmation or move to another screen
  // e.g., navigate back or show a success message
  notifyListeners(); // Notify listeners if you want to update the UI
}

}
