import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/widgets/Schedule%20Screen/day_select_tile.dart';
import 'package:medi_mind/presentation/views/widgets/common/reminder_item.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/dates.dart';
import 'package:medi_mind/utils/dummy_data.dart';


class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}
class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day);

  

  void updateSelectedDay(int value) {
    setState(() {
      selectedDate = selectedDate.copyWith(day: value);
    });
    print("Full selected : $selectedDate");
  }

  void updateSelectedMonth(DateTime? value) {
    if (value != null) {
      setState(() {
        selectedMonth = value;
        selectedDate = selectedDate.copyWith(
            year: selectedMonth.year, month: selectedMonth.month);
        print("Full selected : $selectedDate");
      });
    }
  }

  List<DateTime> generateMonthYearList() {
    final currentYear = DateTime.now().year;
    final startYear = currentYear;
    final endYear = currentYear + 2;

    List<DateTime> monthYearList = [];
    for (int year = startYear; year <= endYear; year++) {
      for (int month = 1; month <= 12; month++) {
        monthYearList.add(DateTime(year, month));
      }
    }
    return monthYearList;
  }

  @override
  Widget build(BuildContext context) {
    List<Reminder> filteredReminders = reminders.where((reminder) {
    // Match selectedDate.weekday with selectedDays
    return reminder.selectedDays.contains(selectedDate.weekday);
  }).toList();

  // Create a combined and sorted list of intakes
  List<Reminder> interleavedIntakes = [];
  for (var reminder in filteredReminders) {
    for (var intake in reminder.intakes) {
      Reminder newReminder = reminder.copyWith(intakes: [intake]);
      interleavedIntakes.add(newReminder);
    }
  }

  // Sort the interleaved intakes by time
  interleavedIntakes.sort((a, b) {
    final timeA = a.intakes[0].time;
    final timeB = b.intakes[0].time;
    return timeA.hour == timeB.hour
        ? timeA.minute.compareTo(timeB.minute)
        : timeA.hour.compareTo(timeB.hour);
  });



    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<DateTime>(
                  icon: Icon(Icons.keyboard_arrow_down_rounded , color: PRIMARY_BLUE,),
                  value: selectedMonth,
                  underline: Container(),
                  items: generateMonthYearList().map((date) {
                    return DropdownMenuItem<DateTime>(
                      value: date,
                      child: Row(
                        children: [
                          Text(
                            "${getMonthNameFromInt(date.month)} ",
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: PRIMARY_BLUE),),
                                Text(
                            "${date.year}",
                            style: const TextStyle(
                                fontSize: 24,
                                
                                color: PRIMARY_BLUE),
                                
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: updateSelectedMonth,
                ),
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      getLastMonthDayFromDate(selectedMonth) -
                          DateTime.now().day +
                          1, (index) {
                    int day = DateTime.now().day + index;
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: DaySelectTile(
                        day: selectedDate.copyWith(day: day),
                        isSelected: selectedDate.day == day,
                        onTap: (int value) => (updateSelectedDay(value)),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: PRIMARY_BLUE,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 20.0, top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("To take",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          )),
                      Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              elevation: 0,
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                              foregroundColor: PRIMARY_BLUE),
                          onPressed: () {
                            Navigator.pushNamed(context, "/addmed");
                          },
                          child: Icon(
                            Icons.add,
                            size: 32,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount: interleavedIntakes.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 0,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ReminderItem(
                            onDismissed: (){},
                            inverseStyle: true,
                            data: interleavedIntakes[index]),
                      );
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}