import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/notification_obj.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/Notifications/notif_widgets.dart';

Reminder sampleReminder = Reminder(
    id: "0",
    name: "Ibuprofen",
    selectedDays: [0,1],
    frequency: 2,
    form: "1 Pill",
    imageUrl: "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
    intakes: [IntakeData.new(dose: 1, time: TimeOfDay.now())]
    );

 NotificationObj notiff = NotificationObj(data:sampleReminder , taskValue: true , notifTime: 3 );
 NotificationObj notiff2 = NotificationObj(data:sampleReminder , taskValue: false , notifTime: 5 );


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBarV2(pageTitle: "Notification"),
      body: SingleChildScrollView( 
        child: Padding(
          padding: EdgeInsets.all(16.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget(sectionTitle: "Today"),
              NotificationItem(notification: notiff),
              NotificationItem(notification: notiff2),
              NotificationItem(notification: notiff),
              NotificationItem(notification: notiff),
              labelWidget(sectionTitle: "Yesterday"),
              NotificationItem(notification: notiff2),
              NotificationItem(notification: notiff),
              NotificationItem(notification: notiff2),
              NotificationItem(notification: notiff),
              labelWidget(sectionTitle: "15 April"),
              NotificationItem(notification: notiff2),
              NotificationItem(notification: notiff),
              NotificationItem(notification: notiff),
              NotificationItem(notification: notiff),
              NotificationItem(notification: notiff),
            ],
          ),
        ),
      ),
    );
  }
}
