class NotificationObj {
  final String name;
  final String unitDose;
  final String takeTime;
  final int taskValue;
  final String notifTime;
  final int sendingTime;
  final String date;

  NotificationObj({
    required this.name,
    required this.unitDose,
    required this.takeTime,
    required this.taskValue,
    required this.notifTime,
    required this.sendingTime,
    required this.date, 
  });


  @override
  String toString() {
    return 'NotificationObj(name: $name, unitDose: $unitDose, takeTime: $takeTime, taskValue: $taskValue, notifTime: $notifTime, sendingTime: $sendingTime, date: $date)';
  }

  factory NotificationObj.fromJson(Map<String, dynamic> json) {
    return NotificationObj(
      name: json['name'] as String,
      unitDose: json['unitDose'] as String,
      takeTime: json['takeTime'] as String,
      taskValue: json['taskValue'] as int,
      notifTime: json['notifTime'] as String,
      sendingTime: json['sendingTime'] as int,
      date: json['date'] as String, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'unitDose': unitDose,
      'takeTime': takeTime,
      'taskValue': taskValue,
      'notifTime': notifTime,
      'sendingTime': sendingTime,
      'date': date, 
    };
  }

  NotificationObj copyWith({String? notifTime, int? sendingTime, String? date}) {
    return NotificationObj(
      name: name,
      unitDose: unitDose,
      takeTime: takeTime,
      taskValue: taskValue,
      notifTime: notifTime ?? this.notifTime,
      sendingTime: sendingTime ?? this.sendingTime,
      date: date ?? this.date, 
    );
  }

  NotificationObj markAsDone({String? notifTime, int? sendingTime, String? date}) {
    return NotificationObj(
      name: name,
      unitDose: unitDose,
      takeTime: takeTime,
      taskValue: 2, // Mark as done
      notifTime: "Just now",
      sendingTime: DateTime.now().millisecondsSinceEpoch,
      date: date ?? this.date,
    );
  }
}
