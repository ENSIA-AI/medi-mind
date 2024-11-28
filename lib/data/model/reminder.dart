class Reminder {
  final String id; // Unique identifier for the reminder
  final String name; // Name of the medication
  final String dosage; // Dosage amount (e.g., "10mg")
  final String frequency; // Frequency of intake (e.g., "Once Per Day")
  final String form; // Form of medication (e.g., "1 Pill")
  final String imageUrl; // URL of the medication image
  final String time; // Reminder time

  const Reminder({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.form,
    required this.imageUrl,
    required this.time,
  });

  /// Factory constructor to create a Reminder from a JSON map
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      form: json['form'] as String,
      imageUrl: json['imageUrl'] as String,
      time: json['time'] as String,
    );
  }

  /// Method to convert a Reminder instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'form': form,
      'imageUrl': imageUrl,
      'time': time,
    };
  }
}
