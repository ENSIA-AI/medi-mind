import 'package:flutter/material.dart';

class IntakeData {
  
  final TimeOfDay time;
  final int dose;

  IntakeData({required this.time, required this.dose});

  /// Factory constructor to create an IntakeData from a JSON map
  factory IntakeData.fromJson(Map<String, dynamic> json) {
    return IntakeData(
      time: TimeOfDay(
        hour: json['hour'] as int,
        minute: json['minute'] as int,
      ),
      dose: json['dose'] as int,
    );
  }

  /// Method to convert an IntakeData instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      
      'hour': time.hour,
      'minute': time.minute,
      'dose': dose,
    };
  }

  /// Method to format TimeOfDay as a string (e.g., "14:30")
  String format24Hour() {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  /// Static method to parse a 24-hour formatted string (e.g., "14:30") to TimeOfDay
  static TimeOfDay parseFromString(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
