import 'package:flutter/material.dart';

extension TimeOfDayFormatter on TimeOfDay {
  // Formats TimeOfDay to a 24-hour time format (HH:mm)
  String format24Hour() {
    final hourString = this.hour.toString().padLeft(2, '0');
    final minuteString = this.minute.toString().padLeft(2, '0');
    return '$hourString:$minuteString';
  }

  // Optionally, you could create a 12-hour format as well
  String format12Hour() {
    final hourString = this.hourOfPeriod == 0
        ? 12
        : this.hourOfPeriod > 12
            ? this.hourOfPeriod - 12
            : this.hourOfPeriod;
    final minuteString = this.minute.toString().padLeft(2, '0');
    final period = this.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hourString:$minuteString $period';
  }
}

const Map<int, String> months = {
  DateTime.january: "January",
  DateTime.february: "February",
  DateTime.march: "March",
  DateTime.april: "April",
  DateTime.may: "May",
  DateTime.june: "June",
  DateTime.july: "July",
  DateTime.august: "August",
  DateTime.september: "September",
  DateTime.october: "October",
  DateTime.november: "November",
  DateTime.december: "December",
};

const Map<int, String> dayNames = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday",
};

String getMonthNameFromInt(int month){
  return months[month] ?? "null";
}

String getDayNameFromDate(DateTime t){
  return dayNames[t.weekday]?.substring(0,3) ?? "null";
}

int getLastMonthDayFromDate(DateTime t){
  return DateTime(t.year, t.month+1).subtract(Duration(days: 1)).day;
}