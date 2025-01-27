import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/widgets/common/reminder_item.dart';

class MedDetails extends StatelessWidget {
  final Map<String, dynamic> reminderData;
  final Function onDismissed;

  const MedDetails(
      {super.key, required this.reminderData, required this.onDismissed});

  // void _showBottomSheet(BuildContext context) {
  //   final screenHeight = MediaQuery.of(context).size.height;
  //   final bottomSheetHeight = screenHeight * 0.9;
  //   String medication = reminderData['name'];
  //   String medDosage = "${reminderData['dose']} ${reminderData['unit']}";
  //   String medTime = reminderData['time'];

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     barrierColor: TRANSPARENT_BG,
  //     builder: (BuildContext context) {
  //       return Container(
  //         decoration: const BoxDecoration(
  //           color: PRIMARY_BLUE,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  //         ),
  //         height: bottomSheetHeight,
  //         child: Column(
  //           children: [
  //             const SizedBox(height: 20),
  //             Center(
  //               child: Container(
  //                 width: 80,
  //                 height: 5,
  //                 decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.all(Radius.circular(16)),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 100),
  //             // Medication Image
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(10),
  //               child: Container(
  //                 width: 150,
  //                 height: 150,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: reminderData['img'] == ""
  //                     ? Icon(Icons.medication)
  //                     : Image.memory(
  //                         Uri.parse(reminderData['img']).data!.contentAsBytes(),
  //                         fit: BoxFit.cover,
  //                         errorBuilder: (context, error, stackTrace) {
  //                           return Image.asset(
  //                             'assets/images/Pills1.png',
  //                             fit: BoxFit.cover,
  //                           );
  //                         },
  //                       ),
  //               ),
  //             ),
  //             const SizedBox(height: 30),
  //             Text(
  //               "$medication , $medDosage",
  //               style: DETAILS_TEXT,
  //               textAlign: TextAlign.center,
  //             ),
  //             const SizedBox(height: 20),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Image.asset('assets/images/Alarm.png', width: 30, height: 30),
  //                 const SizedBox(width: 8),
  //                 Text(medTime, style: DETAILS_ALARM),
  //               ],
  //             ),
  //             const Spacer(),
  //             Row(
  //               children: [
  //                 const SizedBox(width: 220),
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).push(MaterialPageRoute(
  //                         builder: (context) => MedicationDetails(
  //                             medicationData: Medication(
  //                                 reminderDays: reminderData['days']
  //                                     .fold(0, (acc, day) => acc | (1 << day)),
  //                                 id: int.parse(reminderData['id']),
  //                                 name: reminderData['name'],
  //                                 unit: reminderData['unit']))));
  //                   },
  //                   child: Text(
  //                     "See More",
  //                     style: DETAILS_SEE_MORE,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 30),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Map<String, dynamic> _convertToReminderItemFormat() {
    return {
      'id': reminderData['intakeId'],
      'name': reminderData['name'],
      'dose': reminderData['dose'],
      'unit': reminderData['unit'],
      'time': reminderData['time'],
      'img': reminderData['img'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
        },
        child: ReminderItem_(
          data: _convertToReminderItemFormat(),
          onDismissed: (id) {
            onDismissed(id);
          },
        ),
      ),
    );
  }
}
