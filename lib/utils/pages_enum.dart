import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/widgets/reminder_item.dart';
// This page will be changed Later

const HOMEPAGE_INDEX = 0;
const MEDICATION_PAGE_INDEX = 1;
const SCHEDULE_PAGE_INDEX = 2;
const SETTINGS_PAGE_INDEX = 3;

const Reminder sampleReminder = Reminder(
    id: "0",
    name: "Ibuprofen",
    dosage: "500mg",
    frequency: "2 Per Day",
    form: "1 Pill",
    imageUrl: "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
    time: "10:00 AM");

dynamic PAGES_LIST = [
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ReminderItem(
                data: sampleReminder,
              );
            },
          ))
        ],
      ),
    ),
  ),
  Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
    Text("This is My Medication !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.add_alert_rounded)
  ]),
  Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
    Text("This is My Schedule !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.calendar_month),
  ]),
  Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
    Text("This is My Settings !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.settings)
  ]),
];
