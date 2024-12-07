import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/presentation/views/Medication%20Details%20Pages/edit_medication_screen.dart';
import 'package:medi_mind/presentation/views/Medication%20Details%20Pages/edit_schedule_screen.dart';
import 'package:medi_mind/presentation/views/widgets/Medication%20Details/medication_detail_option.dart';
import 'package:medi_mind/presentation/views/widgets/common/action_button.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/common/bottom_sheet.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/binary_selected_days.dart';

class MedicationDetails extends StatefulWidget {
  final Medication medicationData;
  MedicationDetails({
    
    super.key, required this.medicationData,
  });

  @override
  State<MedicationDetails> createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
  
  late List<Reminder_> associatedIntakes = [
    Reminder_(id: 1, medicationId: 1, time: "10:10", dose: 2),
    Reminder_(id: 1, medicationId: 1, time: "10:10", dose: 2),
    Reminder_(id: 1, medicationId: 1, time: "10:10", dose: 2)
  ];

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScheduleScreen(medicationData: widget.medicationData, medicationReminders: associatedIntakes,)));
              },
            ),
            Spacer(),
            Transform.scale(
                scale: 1,
                child: ActionButton(
                    text: "Delete Medication",
                    onPressed: () {
                      showCustomBottomSheet(context, "Delete Medication", "This action is irreversible", "Delete", "Cancel");
                    },
                    style: SECONDARY_ACTION_BUTTON_STYLE,
                    textStyle: SECONDARY_ACTION_BUTTON_TEXT_STYLE))
          ],
        ),
      ),
    );
  }
}
