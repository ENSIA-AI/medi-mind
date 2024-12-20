import 'dart:typed_data';

class Medication {
  final int id; // Unique ID for the medication
  final String name; // Name of the medication
  final String unit; // Unit (e.g., mg, tablet)
  final Uint8List? img; // Path to the medication picture
  final int reminderDays; // binary rep of the week days starting from sunday
  final String? details; // Optional additional details
  final DateTime? endDate; // Optional end date for the medication

  Medication({
    required this.reminderDays,
    required this.id,
    required this.name,
    required this.unit,
    this.img,
    this.details,
    this.endDate,
  });

  // Serialization (to map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'img': img,
      'reminderDays': reminderDays,
      'details': details,
      'endDate': endDate?.toIso8601String(),
    };
  }

  // Deserialization (from map)
  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['id'],
      name: map['name'],
      unit: map['unit'],
      reminderDays: map['reminderDays'],
      img: map['img'],
      details: map['details'],
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
    );
  }
}

class Reminder_ {
  final int id; // Unique ID for the reminder
  final int medicationId; // Foreign key linking to a medication
  final String time; // Reminder time in "HH:mm" format
  final int dose; // Dose to take at this reminder

  Reminder_({
    required this.id,
    required this.medicationId,
    required this.time,
    required this.dose,
  });

  // Serialization (to map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicationId': medicationId,
      'time': time,
      'dose': dose,
    };
  }

  // Deserialization (from map)
  factory Reminder_.fromMap(Map<String, dynamic> map) {
    return Reminder_(
      id: map['id'],
      medicationId: map['medicationId'],
      time: map['time'],
      dose: map['dose'],
    );
  }
}

class Progress {
  final int id; // Unique ID for the progress entry
  final int reminderId; // Foreign key linking to a reminder
  final DateTime? checkedAt; // Timestamp of when the user took action
  final bool isTaken; // 1 : "Done" otherwise "Skipped"

  Progress({
    required this.id,
    required this.reminderId,
    this.checkedAt,
    required this.isTaken,
  });

  // Serialization (to map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reminderId': reminderId,
      'checkedAt': checkedAt?.toIso8601String(),
      'isTaken': isTaken,
    };
  }

  // Deserialization (from map)
  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map['id'],
      reminderId: map['reminderId'],
      checkedAt:
          map['checkedAt'] != null ? DateTime.parse(map['checkedAt']) : null,
      isTaken: map['isTaken'],
    );
  }
}
