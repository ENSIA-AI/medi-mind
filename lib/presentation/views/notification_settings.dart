import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/widgets/Settings/switch_settings.dart';
import 'package:medi_mind/presentation/views/widgets/app_barV2.dart';
import 'package:medi_mind/themes/colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool generalNotification = true;
  bool sound = true;
  bool vibrate = false;
  bool hideMedicationName = false;
  bool repetitiveReminder = true;
  String reminderInterval = '5 Min';
  final List<String> reminderOptions = ['2 Min', '3 Min', '5 Min', '10 Min'];
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarV2(pageTitle: "Notification Setting"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SwitchTile(
              title: 'General Notification',
              boolValue: generalNotification,
              onChanged: (bool value) {
                setState(() {
                  generalNotification = value;
                  print("$value is general");
                });
              },
            ),
            SwitchTile(
              title: 'Sound',
              boolValue: sound,
              onChanged: (bool value) {
                setState(() {
                  sound = value;
                  print("$value is sound: ");
                });
              },
            ),
            SwitchTile(
              title: 'Vibrate',
              boolValue: vibrate,
              onChanged: (bool value) {
                setState(() {
                  vibrate = value;
                  print("$value is vibrate mode ");
                });
              },
            ),
            _buildContainer(
              title: 'Hide Medication Name',
              description:
                  'Your personal information and medication details will be hidden in notifications to protect your privacy.',
              child: SwitchTile(
                title: 'Hide Medication Name',
                boolValue: hideMedicationName,
                onChanged: (bool value) {
                  setState(() {
                    hideMedicationName = value;
                    print("$value is hidden");
                  });
                },
              ),
            ),
            _buildContainer(
              title: 'Repetitive Reminder',
              description:
                  'Enable or disable repetitive reminders to receive multiple notifications for your medication at regular intervals, ensuring you never miss a dose.',
              child: Column(
                children: [
                  SwitchTile(
                    title: 'Repetitive Reminder',
                    boolValue: repetitiveReminder,
                    onChanged: (bool value) {
                      setState(() {
                        repetitiveReminder = value;
                        print("$value repeat at time t");
                      });
                    },
                  ),
                  Row(
                    children: [
                      const Text(
                        "Remind me each",
                        style: TextStyle(
                          fontSize: 14,
                          color: PRIMARY_BLUE,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'LeagueSpartan',
                        ),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        value: reminderInterval,
                        onChanged: (String? newValue) {
                          setState(() {
                            reminderInterval = newValue!;
                          });
                        },
                        items: reminderOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontFamily: 'LeagueSpartan',
                              ),
                            ),
                          );
                        }).toList(),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: PRIMARY_BLUE,
                        ),
                        underline: Container(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: PRIMARY_BLUE,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'LeagueSpartan',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildContainer(
              title: 'Notification Sound',
              description:
                  'Select how you would like the notification to be displayed on your screen.',
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Notification Sound",
                        style: TextStyle(
                          fontSize: 16,
                          color: PRIMARY_BLUE,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'LeagueSpartan',
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          print("Modify the sound of the notification");
                        },
                        child: const Text(
                          "Modify",
                          style: TextStyle(
                            color: SECONDARY_BURGUNDY,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'LeagueSpartan',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSelectableImage(
                        'assets/images/notif_type_one.png',
                        0,
                      ),
                      _buildSelectableImage(
                        'assets/images/notif_type_two.png',
                        1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'LeagueSpartan',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableImage(String imagePath, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedImageIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: selectedImageIndex == index
                    ? SECONDARY_BURGUNDY
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}
