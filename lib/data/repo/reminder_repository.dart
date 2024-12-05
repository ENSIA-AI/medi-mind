import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/data/model/reminder.dart';

class ReminderRepository {
  final DbHelper dbHelper;

  ReminderRepository(this.dbHelper);

  Future<void> saveReminder(Reminder reminder) async {
    await dbHelper.insertReminder(reminder);
  }
}
