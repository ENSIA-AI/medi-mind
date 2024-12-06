class Medication {
  final int id; // Unique ID for the medication
  final String name; // Name of the medication
  final String unit; // Unit (e.g., mg, tablet)
  final String? imgPath; // Path to the medication picture
  final int reminderDays; // Optional days (comma-separated, e.g., "Mon,Wed,Fri")
  final String? details; // Optional additional details
  final DateTime? endDate; // Optional end date for the medication

  Medication({
    required this.reminderDays,
    required this.id,
    required this.name,
    required this.unit,
    this.imgPath,
    this.details,
    this.endDate,
  });

  // Serialization (to map)
  Map<String, dynamic> toMap() {
    return {
      'medicine_id': id,
      'medicine_name': name,
      'unit': unit,
      'img_path': imgPath,
      'reminder_days' : reminderDays,
      'medicine_details': details,
      'medicine_end_date': endDate?.toIso8601String(),
    };
  }

  // Deserialization (from map)
  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['medicine_id'],
      name: map['medicine_name'],
      unit: map['unit'],
      reminderDays: map['reminder_days'],
      imgPath: map['img_path'],
      details: map['medicine_details'],
      endDate: map['medicine_end_date'] != null
          ? DateTime.parse(map['medicine_end_date'])
          : null,
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
      'reminder_id': id,
      'medicine_id': medicationId,
      'reminder_time': time,
      'reminder_dose': dose,
    };
  }

  // Deserialization (from map)
  factory Reminder_.fromMap(Map<String, dynamic> map) {
    return Reminder_(
      id: map['reminder_id'],
      medicationId: map['medicine_id'],
      time: map['reminder_time'],
      dose: map['reminder_dose'],
    );
  }
}

class Progress {
  final int id; // Unique ID for the progress entry
  final int reminderId; // Foreign key linking to a reminder
  final DateTime? checkedAt; // Timestamp of when the user took action
  final String status; // "Taken", "Skipped", "Missed", "Late"

  Progress({
    required this.id,
    required this.reminderId,
    this.checkedAt,
    required this.status,
  });

  // Serialization (to map)
  Map<String, dynamic> toMap() {
    return {
      'progress_id': id,
      'reminder_id': reminderId,
      'checked_at': checkedAt?.toIso8601String(),
      'status': status,
    };
  }

  // Deserialization (from map)
  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map['progress_id'],
      reminderId: map['reminder_id'],
      checkedAt: map['checked_at'] != null
          ? DateTime.parse(map['checked_at'])
          : null,
      status: map['status'],
    );
  }
}