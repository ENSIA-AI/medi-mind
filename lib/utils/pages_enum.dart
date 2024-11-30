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
          const SizedBox(
            height: 200,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return const ReminderItem(
                data: sampleReminder,
              );
            },
          ))
        ],
      ),
    ),
  ),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("This is My Medication !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.add_alert_rounded)
  ]),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("This is My Schedule !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.calendar_month),
  ]),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("This is My Settings !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.settings)
  ]),
];



const List<Map> onBoardingInfo = [
  {
    "imageUrl" : "assets/images/onBoarding1.png",
    "title" : "Start your journey!",
    "description" : "MediMind Helps you eat your breakfast, do your SWE homework and most importantly can do simplex"
  },
  {
    "imageUrl" : "assets/images/onBoarding2.png",
    "title" : "Conquer the world!",
    "description" : "MediMind Helps you eat your dinner, do your OR quiz and most importantly malia dont read this"
  },
  {
    "imageUrl" : "assets/images/onBoarding3.png",
    "title" : "Find your goals!",
    "description" : "MediMind Helps you eat your dinner, do your OR quiz and most importantly malia dont read this"
  }
];