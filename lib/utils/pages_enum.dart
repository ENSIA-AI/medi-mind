import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/presentation/views/local_profile.dart';
import 'package:medi_mind/presentation/views/my_medication.dart';
import 'package:medi_mind/presentation/views/patient_home.dart';
import 'package:medi_mind/presentation/views/schedule_screen.dart';
import 'package:medi_mind/presentation/views/settings_screen.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/dates.dart';
import 'package:medi_mind/utils/dummy_data.dart';
// This page will be changed Later

const HOMEPAGE_INDEX = 0;
const MEDICATION_PAGE_INDEX = 1;
const SCHEDULE_PAGE_INDEX = 2;
const SETTINGS_PAGE_INDEX = 3;

dynamic PAGES_LIST = [
  HomeScreen(),
  MedicationList(meds: medications_dummy),
  ScheduleScreen(),
  
  LocalProfile(),
];

const List<Map> onBoardingInfo = [
  {
    "imageUrl": "assets/images/onBoarding1.png",
    "title": "Stay on Track",
    "description":
        "MediMind helps you manage your medications by setting timely reminders, so you never forget a dose."
  },
  {
    "imageUrl": "assets/images/onBoarding2.png",
    "title": "Track Your Progress",
    "description":
        "Easily track your medication progress. Mark your doses as taken, skipped, or missed, and stay updated with your health goals."
  },
  {
    "imageUrl": "assets/images/onBoarding3.png",
    "title": "Get Insights",
    "description":
        "Get personalized insights and overviews of your medication schedules. "
  }
];
