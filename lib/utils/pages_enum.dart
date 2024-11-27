import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/widgets/logo_name_widget.dart';
// This page will be changed Later

const HOMEPAGE_INDEX = 0;
const MEDICATION_PAGE_INDEX = 1;
const SCHEDULE_PAGE_INDEX = 2;
const SETTINGS_PAGE_INDEX = 3;
const PAGES_LIST = [
  LogoNameWidget(),
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
