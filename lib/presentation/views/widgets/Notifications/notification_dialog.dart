import 'package:flutter/material.dart';
import 'package:medi_mind/themes/styles.dart';

// NotificationAlert widget

//TODO: maybe change the color of the btn and bg later
class NotificationAlert extends StatelessWidget {
  final String medName;
  final String medTime;

  const NotificationAlert(
      {super.key, required this.medName, required this.medTime});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  content: Container(
    width: 400,
    height: 160,
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          Image.asset(
            'assets/images/notif_pic.png',
            width: 30,
            height: 30,
          ),
          const SizedBox(height: 5),
          Text(medName, style: BLACK_REGULAR_TEXT_STYLE),
          Text(medTime, style: BLACK_REGULAR_TEXT_STYLE),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  print("done");
                },
                style: GREEN_NOTIFICATION_BTN,
                child: Text(
                  "done",
                  style: REGULAR_TEXT_STYLE_WHITE,
                ),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: () {
                  print("skip");
                },
                style: RED_NOTIFICATION_BTN,
                child: Text(
                  "skip",
                  style: REGULAR_TEXT_STYLE_WHITE,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
)
;
  }
}

//  to invoke the notification later  modify the invoke way depending on the logic 
class InvokNotif extends StatelessWidget {
  const InvokNotif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication Reminder App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            
            showDialog(
              barrierColor: TRANSPARENT_BG,
              context: context,
              builder: (BuildContext context) {
                return const NotificationAlert(
                  medName: 'Aspirin', // Example medication
                  medTime: '8:00 AM', // Example time
                );
              },
            );
          },
          child: const Text('Show Medication Reminder'),
        ),
      ),
    );
  }
}
