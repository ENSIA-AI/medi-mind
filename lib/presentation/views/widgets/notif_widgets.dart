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
                offset: Offset(0, 3),
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
                        notification.taskValue ? Colors.green : SECONDARY_BURGUNDY,
                    shape: BoxShape.circle,
                  ),
                  child: notification.taskValue
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
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: PRIMARY_BLUE,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: notification.data.name,
                            style: const TextStyle(
                              color: PRIMARY_BLUE,
                              fontWeight: FontWeight.bold,
                               fontSize: 20
                            ),
                          ),
                          const TextSpan(
                            text: ' , ',
                            style: TextStyle(
                              color: PRIMARY_BLUE,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
        
                          ),
                          TextSpan(
                            text: notification.data.dosage,
                            style: const TextStyle(
                              color: PRIMARY_BLUE,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
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
                          notification.data.time,
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
                notification.notifTime.truncate().toString() + 'min',
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
