import 'package:medi_mind/data/model/reminder.dart';

class NotificationObj {
  final Reminder data; // The associated reminder data
  final bool taskValue; // Task completion status : true medication taken else false
  final double notifTime; // the value is in minutes

  NotificationObj({
    required this.data,
    required this.taskValue,
    required this.notifTime
  });

  /// Factory constructor to create a NotificationObj from a JSON map
  factory NotificationObj.fromJson(Map<String, dynamic> json) {
    return NotificationObj(
      data: Reminder.fromJson(json['data'] as Map<String, dynamic>),
      taskValue: json['taskValue'] as bool,
       notifTime: json['notifTime'] as double,
    );
  }

  /// Method to convert a NotificationObj instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'taskValue': taskValue,
       'notifTime': notifTime,
    };
  }
}
