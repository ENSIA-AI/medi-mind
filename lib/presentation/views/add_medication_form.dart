import 'package:flutter/material.dart';
import 'package:medi_mind/consts/consts.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/providers/addMedication/medication_provider.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/SelectTimes.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/day_selector.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/intake_complex_input.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_image_picker.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_select_form_field.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_text_form_field.dart';
import 'package:medi_mind/presentation/views/widgets/common/action_button.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/toast_message.dart';
import 'package:provider/provider.dart';

class AddMedicationPage extends StatelessWidget {
  const AddMedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicationProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Add a Medication",
            style: BLUE_SUBHEADING_TEXT_STYLE,
          ),
          centerTitle: true,
        ),
        body: Consumer<MedicationProvider>(
          builder: (context, medicationProvider, child) {
            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: medicationProvider.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Step 1: Medication Details
                      _buildMedicationDetailsStep(medicationProvider),

                      // Step 2: Times Per Day
                      _buildTimesPerDayStep(medicationProvider),

                      // Step 3: Reminders
                      _buildRemindersStep(medicationProvider),

                      // Step 4: Days Selection
                      _buildDaySelectionStep(medicationProvider),
                    ],
                  ),
                ),

                // Bottom Navigation Buttons
                _buildBottomNavigation(medicationProvider, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMedicationDetailsStep(MedicationProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        child: Column(
          children: [
            MedicationImagePicker(
              imageController: ValueNotifier(provider.image),
              onImageSelected: provider.updateImage,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "What medication would you like to add ?",
                style: TextStyle(
                    fontSize: 20,
                    color: PRIMARY_BLUE,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MedicationTextFormField(
              label: "Name",
              placeholder: "Eg: Ibuprofen",
              controller: provider.medicationNameController,
            ),
            SizedBox(
              height: 20,
            ),
            MedicationSelectFormField(
              options: MEDICATION_UNITS,
              selectedValue: provider.selectedUnit,
              label: "Unit",
              onSelect: provider.updateSelectedUnit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimesPerDayStep(MedicationProvider provider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Center(
            child: Image.asset(
              "assets/images/Board.png",
              height: 150,
              width: 150,
            ),
          ),
        ),
        Text(
          "What daily frequency suits you best?",
          style: TextStyle(
            fontSize: 20,
            color: PRIMARY_BLUE,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(16.0),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              for (int i = 1; i <= 6; i++)
                MedTimes(
                  value: "$i times",
                  imgIndex: i,
                  selectedValue: provider.timesPerDay,
                  onSelect: provider.updateTimesPerDay,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRemindersStep(MedicationProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Center(
              child: Image.asset(
                "assets/images/Board.png",
                height: 150,
                width: 150,
              ),
            ),
          ),
          Text(
            "When would you like to be reminded?",
            style: TextStyle(
                fontSize: 20, color: PRIMARY_BLUE, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: provider.timesPerDay,
                itemBuilder: (_, index) {
                  return IntakeComplexInput(
                    index: index, // The index of the intake data
                    time: provider.intakeDataList[index].time, // Pass the time
                    dose: provider.intakeDataList[index].dose, // Pass the dose
                    unit: provider.selectedUnit ?? "null(s)", // Pass the unit
                    onTimeChanged: (newTime) {
                      provider.updateIntakeData(
                          index,
                          IntakeData(
                              time: newTime,
                              dose: provider.intakeDataList[index].dose));
                    },
                    onDoseChanged: (newDose) {
                      provider.updateIntakeData(
                          index,
                          IntakeData(
                              time: provider.intakeDataList[index].time,
                              dose: newDose));
                    },
                    label: "Intake ${index + 1}",
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildDaySelectionStep(MedicationProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Center(
              child: Image.asset(
                "assets/images/Board.png",
                height: 150,
                width: 150,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "On what days would you like to be reminded?",
              style: TextStyle(
                  fontSize: 20,
                  color: PRIMARY_BLUE,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          DaySelector(
            selectedDays: provider.selectedDays,
            onDaysSelected: provider.updateSelectedDays,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(
      MedicationProvider provider, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (provider.currentStep > 0)
            ActionButton(
              text: "Back",
              onPressed: provider.previousStep,
              style: SECONDARY_ACTION_BUTTON_STYLE,
              textStyle: SECONDARY_ACTION_BUTTON_TEXT_STYLE,
            ),
          ActionButton(
            text: provider.currentStep == 3 ? "Finish" : "Next",
            onPressed: () async {
              bool result = await provider.nextStep();
              print(provider.currentStep);
              if (result && provider.currentStep == 4) {
                ShowToastMessage("Added Medication Successfully!");
                
                Navigator.of(context).pushReplacementNamed('/main');
              }
            },
            style: PRIMARY_ACTION_BUTTON_STYLE,
            textStyle: PRIMARY_ACTION_BUTTON_TEXT_STYLE,
          ),
        ],
      ),
    );
  }
}
