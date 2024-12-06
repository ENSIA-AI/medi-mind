import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/widgets/common/reminder_item.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class MedDetails extends StatelessWidget {
  final Reminder medREminder;
  final Function onDismissed;
  const MedDetails({super.key, required this.medREminder, required this.onDismissed});

  void _showBottomSheet(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.9;
    String medication = medREminder.name;
    String medDosage = medREminder.intakes[0].dose.toString();
    String medTime = medREminder.intakes[0].format24Hour();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      barrierColor: TRANSPARENT_BG,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: PRIMARY_BLUE,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          height: bottomSheetHeight,
          child: Column(
            children: [
              // Handle at the top
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 80,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              // Medication Image
              Image.asset(
                'assets/images/Pills1.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 30),
              // Medication Details
              Text(
                "$medication , $medDosage",
                style: DETAILS_TEXT,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Time and Alarm Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Alarm.png', width: 30, height: 30),
                  const SizedBox(width: 8),
                  Text(medTime, style: DETAILS_ALARM),
                ],
              ),
              const Spacer(),
              // "See More" Button
              Row(
                children: [
                  const SizedBox(width: 220),
                  TextButton(
                    onPressed: () {
                      // will be a navigation page
                      print('See More tapped');
                    },
                    child: Text(
                      "See More",
                      style: DETAILS_SEE_MORE,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {
              _showBottomSheet(context);
              print('Widget clicked!');
            },
            child: ReminderItem(data:medREminder , onDismissed: onDismissed,)));
  }
}
