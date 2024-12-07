import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/day_selector.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/profile/action_button.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/binary_selected_days.dart';

class EditScheduleScreen extends StatefulWidget {
  final Medication medicationData;
  final List<Reminder_> medicationReminders;
  const EditScheduleScreen(
      {super.key,
      required this.medicationData,
      required this.medicationReminders});

  @override
  State<EditScheduleScreen> createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen> {
  late Set<int> selectedDays;
  late DateTime? selectedEndDate;
  late bool initialEndDateIsSet;
  late int dailyFrequency;
  bool showSaveButton = false;
  @override
  void initState() {
    super.initState();
    selectedDays = getSelectedDays(widget.medicationData.reminderDays);
    selectedEndDate = widget.medicationData.endDate ?? DateTime.now();
    initialEndDateIsSet = (widget.medicationData.endDate == null);
    dailyFrequency = widget.medicationReminders.length;
  }

  void updateSelectedDays(Set<int> days) {
    setState(() {
      selectedDays = days;
      showSaveButton = true;
    });
  }

  Future<void> pickEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // One year range
    );
    if (pickedDate != null) {
      setState(() {
        selectedEndDate = pickedDate;
        initialEndDateIsSet = true;
        showSaveButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarV2(pageTitle: "Medication Schedule"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    "Frequency & Week Reminders",
                    style: TextStyle(
                      color: PRIMARY_BLUE,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: DaySelector(
                      selectedDays: selectedDays,
                      onDaysSelected: updateSelectedDays,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Daily Frequency",
                        style: TextStyle(
                          color: PRIMARY_BLUE,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      DropdownButton<int>(
                        value: dailyFrequency,
                        onChanged: (int? newValue) {
                          setState(() {
                            dailyFrequency = newValue!;
                            showSaveButton = true;
                          });
                        },
                        items: List.generate(
                            6,
                            (index) => DropdownMenuItem<int>(
                                  value: (index+1),
                                  child: Text(
                                    "${index+1} per day",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Spartan League',
                                    ),
                                  ),
                                )),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: PRIMARY_BLUE,
                        ),
                        underline: Container(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: PRIMARY_BLUE,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Spartan League',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "End Date",
                  style: TextStyle(
                    color: PRIMARY_BLUE,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                subtitle: (initialEndDateIsSet)
                    ? Text(
                        "${selectedEndDate!.year}-${selectedEndDate!.month.toString().padLeft(2, '0')}-${selectedEndDate!.day.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        "No end date selected",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                trailing: Icon(
                  Icons.calendar_month,
                  color: PRIMARY_BLUE,
                  size: 28,
                ),
                onTap: () => pickEndDate(context),
              ),
              Spacer(),
              ActionButton(text: "Save", onPressed: (){
                Navigator.pop(context);
              }, style: PRIMARY_ACTION_BUTTON_STYLE, textStyle: PRIMARY_ACTION_BUTTON_TEXT_STYLE)
            ],
          ),
        ),
      ),
    );
  }
}
