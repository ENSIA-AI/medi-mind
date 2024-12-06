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

    Future<bool> nextStep() async {
      if (currentStep < 3) {
        currentStep++;
        pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        notifyListeners();
        return true;
      }
      else{
        return await finish();
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


  Future<bool> finish() async {
    var uuid = Uuid();
    
    
    if (medicationNameController.text.isEmpty || selectedUnit == null || selectedDays.isEmpty) {
      // Show an error or return early if the data is incomplete
      return false;
    }
    

    
    String reminderId = uuid.v4(); // Generate a UUIDv4
    
    
    
    Reminder reminder = Reminder(
      id: reminderId,
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
    
    
    notifyListeners(); 

    return true;
  }

  }
