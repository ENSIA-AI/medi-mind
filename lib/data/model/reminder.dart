import 'package:medi_mind/data/model/intake.dart';

class Reminder {
  final String id;
  final String name;
  final int frequency;
  final String form;
  final String imageUrl;
  final List<IntakeData> intakes;
  final List<int> selectedDays;
  final DateTime? endDate;

  const Reminder({
    required this.id,
    required this.name,
    required this.frequency,
    required this.form,
    required this.imageUrl,
    required this.intakes,
    required this.selectedDays,
    this.endDate,
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
      selectedDays: List<int>.from(json['selectedDays'] as List),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
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
      'selectedDays': selectedDays,
      'endDate': endDate?.toIso8601String(),
    };
  }

  /// `copyWith` method to create a new Reminder instance with modified properties
  Reminder copyWith({
    String? id,
    String? name,
    int? frequency,
    String? form,
    String? imageUrl,
    List<IntakeData>? intakes,
    List<int>? selectedDays,
    DateTime? endDate,
  }) {
    return Reminder(
      id: id ?? this.id,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      form: form ?? this.form,
      imageUrl: imageUrl ?? this.imageUrl,
      intakes: intakes ?? this.intakes,
      selectedDays: selectedDays ?? this.selectedDays,
      endDate: endDate ?? this.endDate,
    );
  }
}
