import 'package:medi_mind/data/model/intake.dart';

class Reminder {
  final String id; // Unique identifier for the reminder
  final String name; // Name of the medication
  final int frequency; // Frequency of intake (e.g., "Once Per Day")
  final String form; // Form of medication (e.g., "Pill(s)")
  final String imageUrl; // URL of the medication image
  final List<IntakeData> intakes; // List of intake details
  final List<int> selectedDays; // List of selected days (e.g., [0, 1, 2] for Sunday, Monday, Tuesday)
  final DateTime? endDate; // Nullable end date for taking the medication

  const Reminder({
    required this.id,
    required this.name,
    required this.frequency,
    required this.form,
    required this.imageUrl,
    required this.intakes,
    required this.selectedDays, // Add selectedDays as a required parameter
    this.endDate, // Nullable end date
  });

  /// Factory constructor to create a Reminder from a JSON map
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      name: json['name'] as String,
      frequency: json['frequency'] as int,
      form: json['form'] as String,
      imageUrl: json['imageUrl'] as String,
      intakes: (json['intakes'] as List<dynamic>)
          .map((e) => IntakeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedDays: List<int>.from(json['selectedDays'] as List), // Parse the selectedDays list
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null, // Parse endDate if it exists
    );
  }

  /// Method to convert a Reminder instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
      'form': form,
      'imageUrl': imageUrl,
      'intakes': intakes.map((e) => e.toJson()).toList(),
      'selectedDays': selectedDays, // Include selectedDays in the JSON map
      'endDate': endDate?.toIso8601String(), // Convert endDate to ISO 8601 string if it's not null
    };
  }
}
