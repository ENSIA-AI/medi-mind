import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/notification_obj.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/widgets/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/notif_widgets.dart';

///____________________________data used for the style __________________________________
const Reminder sampleReminder = Reminder(
    id: "0",
    name: "Ibuprofen",
    dosage: "500mg",
    frequency: "2 Per Day",
    form: "1 Pill",
    imageUrl: "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
    time: "10:00 AM");

const NotificationObj notiff = NotificationObj(data:sampleReminder , taskValue: true , notifTime: 3 );
const NotificationObj notiff2 = NotificationObj(data:sampleReminder , taskValue: false , notifTime: 5 );


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
