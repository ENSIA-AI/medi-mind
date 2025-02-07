import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/data/model/notification_obj.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

List<NotificationObj> notificationsToDisplay = [];

Future<List<NotificationObj>> fetchNotificationsToDisplay() async {
  await loadNotificationsFromDB(); 
  List<Map<String, dynamic>> notifications = await getNotificationData();
  int currentTime = DateTime.now().millisecondsSinceEpoch;

  DateTime currentDate = DateTime.now();
  DateTime startOfDay =
      DateTime(currentDate.year, currentDate.month, currentDate.day);
  DateTime endOfDay = DateTime(
      currentDate.year, currentDate.month, currentDate.day, 23, 59, 59, 999);

  for (var item in notifications) {
    String takeTimeStr = item["time"];
    DateTime takeTime = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      int.parse(takeTimeStr.split(":")[0]),
      int.parse(takeTimeStr.split(":")[1]),
    );

    if (takeTime.isBefore(startOfDay) || takeTime.isAfter(endOfDay)) continue;

    int takeTimeMillis = takeTime.millisecondsSinceEpoch;
    int taskValue =
        (currentTime <= takeTimeMillis) ? 1 : (item["status"] == 0 ? 0 : 1);

    
    NotificationObj existingNotification = notificationsToDisplay.firstWhere(
      (n) => n.name == item["medicationName"] && n.takeTime == item["time"],
      orElse: () => NotificationObj(
        name: item["medicationName"],
        unitDose: "${item["dose"]} ${item["unit"]}",
        takeTime: item["time"],
        taskValue: taskValue,
        notifTime: "",
        sendingTime: takeTimeMillis,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ),
    );

   
    int sendingTime = existingNotification.sendingTime;
    String updatedNotifTime = calculateTimePassed(sendingTime, currentTime);

    NotificationObj newNotification = existingNotification.copyWith(
      notifTime: updatedNotifTime,
      sendingTime: sendingTime,
    );

    
    notificationsToDisplay.removeWhere((n) =>
        n.name == newNotification.name &&
        n.takeTime == newNotification.takeTime);
    notificationsToDisplay.add(newNotification);
  }

  
  notificationsToDisplay.sort((a, b) => sortByTime(a, b));

  return notificationsToDisplay;
}


Future<List<Map<String, dynamic>>> getNotificationData() async {
  final db = await DbHelper().database;
  final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT 
      m.name AS medicationName,
      i.dose,
      m.unit,
      i.time,
      COALESCE(p.status, 0) AS status 
    FROM intakes i
    JOIN medications m ON i.medicationId = m.id
    LEFT JOIN progress p ON i.id = p.intakeId AND p.date = date('now')
    ORDER BY i.time ASC
  ''');

  int currentTime = DateTime.now().millisecondsSinceEpoch;

  return results.map((item) {
    int sendingTime = currentTime;
    return {
      ...item,
      "sendingTime": sendingTime,
      "timePassed": calculateTimePassed(sendingTime, currentTime),
    };
  }).toList();
}


String calculateTimePassed(int sendingTime, int currentTime) {
  int diffInSeconds = (currentTime - sendingTime) ~/ 1000;

  if (diffInSeconds < 60) {
    return diffInSeconds <= 0 ? "Just now" : "$diffInSeconds sec ago";
  } else if (diffInSeconds < 3600) {
    return "${diffInSeconds ~/ 60} min ago";
  } else if (diffInSeconds < 86400) {
    return "${diffInSeconds ~/ 3600} hours ago";
  } else {
    return "${diffInSeconds ~/ 86400} days ago";
  }
}

Future<void> saveNotificationsToDB() async {
  final db = await DbHelper().database;

  for (var notification in notificationsToDisplay) {
    await db.insert(
      'notifications',
      {
        ...notification.toJson(),
        "notifTime": notification.notifTime,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}


Future<void> loadNotificationsFromDB() async {
  final db = await DbHelper().database;
  final List<Map<String, dynamic>> storedNotifications =
      await db.rawQuery('SELECT * FROM notifications ORDER BY takeTime ASC');

  int currentTime = DateTime.now().millisecondsSinceEpoch;
  notificationsToDisplay = storedNotifications.map((n) {
    int sendingTime = n["sendingTime"] ?? DateTime.now().millisecondsSinceEpoch;
    return NotificationObj.fromJson(n).copyWith(
      notifTime: calculateTimePassed(sendingTime, currentTime),
      sendingTime: sendingTime,
    );
  }).toList();

 
  notificationsToDisplay.sort((a, b) => sortByTime(a, b));
}



void startNotificationUpdater() {
  Timer.periodic(const Duration(seconds: 10), (timer) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    notificationsToDisplay = notificationsToDisplay.map((n) {
      return n.copyWith(
          notifTime: calculateTimePassed(n.sendingTime, currentTime));
    }).toList();
  });
}


int sortByTime(NotificationObj a, NotificationObj b) {
  try {
    DateTime now = DateTime.now();
    DateTime takeTimeA =
        DateTime.parse("2022-01-01 ${a.takeTime.padLeft(5, '0')}:00");
    DateTime takeTimeB =
        DateTime.parse("2022-01-01 ${b.takeTime.padLeft(5, '0')}:00");

    int diffA = (takeTimeA.difference(now)).inMilliseconds.abs();
    int diffB = (takeTimeB.difference(now)).inMilliseconds.abs();

    int timeComparison = diffA.compareTo(diffB);
    if (timeComparison != 0) return timeComparison;

    return a.name.compareTo(b.name);
  } catch (e) {
    print("Error parsing time: ${a.takeTime} or ${b.takeTime}, Error: $e");
    return 0;
  }
}

Future<void> markReminderAsDone({
  required int intakeId,
  required String nowdate,
}) async {
  int currentTime = DateTime.now().millisecondsSinceEpoch;
  final db = await DbHelper().database;

 
  final List<Map<String, dynamic>> reminder = await db.rawQuery('''
  SELECT m.name, m.unit, i.time
  FROM intakes i
  JOIN medications m ON i.medicationId = m.id
  WHERE i.id = ?
''', [intakeId]);

  if (reminder.isEmpty) {
    return; 
  }

  final String name = reminder.first['name'] as String;
  final String unitDose = reminder.first['unit'] as String; 
  final String takeTime =
      reminder.first['time'] as String;


  NotificationObj? existingNotification = notificationsToDisplay.firstWhere(
    (n) => n.name == name && n.takeTime == takeTime,
    orElse: () => NotificationObj(
      name: name,
      unitDose: unitDose,
      takeTime: takeTime,
      taskValue: 2,
      notifTime: "Just now",
      sendingTime: currentTime,
      date: nowdate,
    ),
  );

 
  NotificationObj updatedNotification = existingNotification.markAsDone(
    notifTime: "Just now",
    sendingTime: currentTime,
  );

 
  notificationsToDisplay.removeWhere((n) =>
      n.name == updatedNotification.name &&
      n.takeTime == updatedNotification.takeTime);
  notificationsToDisplay.add(updatedNotification);

  notificationsToDisplay.sort((a, b) => sortByTime(a, b));
  print(" the mark as done one ");
  print(existingNotification);
 
  await updateNotificationInDB(updatedNotification);
}

Future<void> updateNotificationInDB(NotificationObj notification) async {
  final db = await DbHelper().database;

  
  final List<Map<String, dynamic>> existing = await db.query(
    'notifications',
    where: "name = ? AND takeTime = ?",
    whereArgs: [notification.name, notification.takeTime],
  );

  if (existing.isNotEmpty) {
    
    int updatedRows = await db.update(
      'notifications',
      notification.toJson(),
      where: "name = ? AND takeTime = ?",
      whereArgs: [notification.name, notification.takeTime],
    );

    print("Updated $updatedRows rows in notifications table.");
  } else {
   
    int insertedId = await db.insert(
      'notifications',
      notification.toJson(),
    );
    print(notification);
    print("Inserted new notification with ID: $insertedId");
  }
}
