import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/notification_obj.dart';
import 'package:medi_mind/themes/colors.dart';

// require the string value
class labelWidget extends StatelessWidget {
  final String sectionTitle;
  const labelWidget({super.key, required this.sectionTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: TEXT_BEIGE,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              sectionTitle,
              style: const TextStyle(
                color: PRIMARY_BLUE,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,)
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationObj notification;
  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color:
                        notification.taskValue >= 1? Colors.green : SECONDARY_BURGUNDY,// if = 1 means that the notification have been taken 
                    shape: BoxShape.circle,
                  ),
                  child: notification.taskValue >= 1
                      ? const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 35,
                        )
                      : const Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 35,
                        )),
              const SizedBox(width: 16),
              // Medication details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(
                            notification.taskValue == 1 ? "Next Reminder For ":notification.taskValue == 2? "Medication taken": "Missed Reminder",
                            style: TextStyle(
                              color:  notification.taskValue >= 1? Colors.green : SECONDARY_BURGUNDY,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Spartan League",
                               fontSize: 20
                            ),
                          ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: PRIMARY_BLUE,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: notification.name,
                            style: const TextStyle(
                              color: PRIMARY_BLUE,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Spartan League",
                               fontSize: 17
                            ),
                          ),
                          const TextSpan(
                            text: ' , ',
                            style: TextStyle(
                              color: PRIMARY_BLUE,
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),
        
                          ),
                          TextSpan(
                            text: notification.unitDose,
                            style: const TextStyle(
                              color: PRIMARY_BLUE,
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.alarm,
                          size: 18,
                          color: PRIMARY_BLUE,
        
                        ),
                        const SizedBox(width: 4),
                        Text(
                          notification.takeTime, // fix the format if needed later
                          style: const TextStyle(
                            color: PRIMARY_BLUE,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Duration
              Text(
                notification.notifTime,
                style: const TextStyle(
                  color: PRIMARY_BLUE,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5,)
      ],
    );
  }
}
