import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/patient_home.dart';
import 'package:medi_mind/presentation/views/schedule_screen.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/dates.dart';
// This page will be changed Later

const HOMEPAGE_INDEX = 0;
const MEDICATION_PAGE_INDEX = 1;
const SCHEDULE_PAGE_INDEX = 2;
const SETTINGS_PAGE_INDEX = 3;

dynamic PAGES_LIST = [
  HomeScreen(),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("This is My Medication !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.add_alert_rounded)
  ]),
  ScheduleScreen(),
  
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
    "imageUrl": "assets/images/onBoarding1.png",
    "title": "Start your journey!",
    "description":
        "MediMind Helps you eat your breakfast, do your SWE homework and most importantly can do simplex"
  },
  {
    "imageUrl": "assets/images/onBoarding2.png",
    "title": "Conquer the world!",
    "description":
        "MediMind Helps you eat your dinner, do your OR quiz and most importantly malia dont read this"
  },
  {
    "imageUrl": "assets/images/onBoarding3.png",
    "title": "Find your goals!",
    "description":
        "MediMind Helps you eat your dinner, do your OR quiz and most importantly malia dont read this"
  }
];
