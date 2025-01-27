import 'package:flutter/material.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/presentation/views/Medication%20Details%20Pages/edit_medication_screen.dart';
import 'package:medi_mind/presentation/views/Medication%20Details%20Pages/edit_schedule_screen.dart';
import 'package:medi_mind/presentation/views/widgets/Medication%20Details/medication_detail_option.dart';
import 'package:medi_mind/presentation/views/widgets/common/action_button.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/common/bottom_sheet.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/binary_selected_days.dart';
import 'package:medi_mind/utils/toast_message.dart';

class MedicationDetails extends StatefulWidget {
  final Medication medicationData;
  MedicationDetails({
    
    super.key, required this.medicationData,
  });

  @override
  State<MedicationDetails> createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
    final DbHelper _dbHelper = DbHelper();

  Future<void> _deleteMedication() async {
    print("I'm CALLED on ${widget.medicationData.id}");
    var db = await _dbHelper.database;
    await db.delete(
      'medications',
      where: 'id = ?',
      whereArgs: [widget.medicationData.id],
    );
    await db.delete(
      'intakes',
      where: 'medicationId = ?',
      whereArgs: [widget.medicationData.id],
    );
    ShowToastMessage("Medication Deleted");
    Navigator.pop(context); // Close the bottom sheet
    Navigator.pop(context); // Go back to the previous screen
  }
  
  @override
  Widget build(BuildContext context) {
    List<Reminder_> associatedIntakes = widget.medicationData.intakes ?? [];
    return Scaffold(
      appBar: AppBarV2(pageTitle: "Medication Details"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MedicationDetailOption(
              title: widget.medicationData.name,
              description: "Manage medication data.",
              icon: Icon(Icons.medication),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => EditMedicationScreen(medicationData: widget.medicationData,)));

              },
            ),
            SizedBox(
              height: 20,
            ),
            MedicationDetailOption(
              title: "Schedule",
              description: "${associatedIntakes.length} per day - ${countSetBits(widget.medicationData.reminderDays)} per week - No end date",
              icon: Icon(Icons.calendar_month),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScheduleScreen(medicationData: widget.medicationData)));
              },
            ),
            Spacer(),
            Transform.scale(
                scale: 1,
                child: ActionButton(
                    text: "Delete Medication",
                    onPressed: () {
                      showCustomBottomSheet(context, "Delete Medication", "This action is irreversible", "Delete", "Cancel", leftBtnAction: _deleteMedication, rightBtnAction: () => Navigator.pop(context));
                    },
                    style: SECONDARY_ACTION_BUTTON_STYLE,
                    textStyle: SECONDARY_ACTION_BUTTON_TEXT_STYLE))
          ],
        ),
      ),
    );
  }
}
