import 'package:flutter/material.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/day_selector.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/profile/action_button.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/binary_selected_days.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/intake_complex_input.dart';
import 'package:medi_mind/utils/toast_message.dart';

class EditScheduleScreen extends StatefulWidget {
  final Medication medicationData;
  final List<Reminder_> medicationReminders;

  EditScheduleScreen({
    Key? key,
    required this.medicationData,
    
  }) : medicationReminders = medicationData.intakes ?? [],  super(key: key);

  @override
  _EditScheduleScreenState createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen> {
  late Set<int> selectedDays;
  late DateTime? selectedEndDate;
  late bool initialEndDateIsSet;
  late int dailyFrequency;
  bool showSaveButton = false;
  final DbHelper _dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    selectedDays = getSelectedDays(widget.medicationData.reminderDays);
    selectedEndDate = widget.medicationData.endDate ?? DateTime.now();
    initialEndDateIsSet = (widget.medicationData.endDate != null);
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

  Future<void> _saveSchedule() async {
    var db = await _dbHelper.database;
    await db.update(
      'medications',
      {
        'reminderDays':
            selectedDays.fold<int>(0, (acc, day) => acc | (1 << day)),
        'endDate': selectedEndDate?.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [widget.medicationData.id],
    );

    // Delete existing reminders for the medication
    await db.delete(
      'intakes',
      where: 'medicationId = ?',
      whereArgs: [widget.medicationData.id],
    );

    // Insert new reminders
    for (var reminder in widget.medicationReminders) {
      await db.insert(
        'intakes',
        {
          'id': reminder.id,
          'medicationId': reminder.medicationId,
          'time': reminder.time,
          'dose': reminder.dose,
        },
      );
    }

    ShowToastMessage("Updated Medication Successfully");
    Navigator.popUntil(context, ModalRoute.withName('/main'));
  }

  void _updateReminder(Reminder_ reminder) {
    setState(() {
      showSaveButton = true;
    });
  }

  void _adjustDailyFrequency(int newFrequency) {
    setState(() {
      if (newFrequency > dailyFrequency) {
        // Add new reminders
        for (int i = dailyFrequency; i < newFrequency; i++) {
          widget.medicationReminders.add(Reminder_(
            id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
            medicationId: widget.medicationData.id,
            time: '08:00', // Default time
            dose: 1, // Default dose
          ));
        }
      } else {
        // Remove excess reminders
        widget.medicationReminders.removeRange(newFrequency, dailyFrequency);
      }
      dailyFrequency = newFrequency;
      showSaveButton = true;
    });
  }

  Future<void> _pickTime(BuildContext context, Reminder_ reminder) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(reminder.time.split(':')[0]),
        minute: int.parse(reminder.time.split(':')[1]),
      ),
    );
    if (pickedTime != null) {
      setState(() {
        reminder.time =
            '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
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
                          if (newValue != null) {
                            _adjustDailyFrequency(newValue);
                          }
                        },
                        items: List.generate(
                            6,
                            (index) => DropdownMenuItem<int>(
                                  value: (index + 1),
                                  child: Text(
                                    "${index + 1} per day",
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
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.medicationReminders.length,
                  itemBuilder: (context, index) {
                    final reminder = widget.medicationReminders[index];
                    return IntakeComplexInput(
                      index: index,
                      time: TimeOfDay(
                        hour: int.parse(reminder.time.split(':')[0]),
                        minute: int.parse(reminder.time.split(':')[1]),
                      ),
                      dose: reminder.dose,
                      unit: widget.medicationData.unit,
                      onTimeChanged: (newTime) {
                        setState(() {
                          reminder.time =
                              '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                          showSaveButton = true;
                        });
                      },
                      onDoseChanged: (newDose) {
                        setState(() {
                          reminder.dose = newDose;
                          showSaveButton = true;
                        });
                      },
                      label: "Intake ${index + 1}",
                    );
                  },
                ),
              ),
              if (showSaveButton)
                ActionButton(
                  text: "Save",
                  onPressed: _saveSchedule,
                  style: PRIMARY_ACTION_BUTTON_STYLE,
                  textStyle: PRIMARY_ACTION_BUTTON_TEXT_STYLE,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
