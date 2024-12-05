import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/widgets/Schedule%20Screen/day_select_tile.dart';
import 'package:medi_mind/presentation/views/widgets/common/reminder_item.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/dates.dart';
import 'package:medi_mind/utils/pages_enum.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}
class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month);

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
                  value: selectedMonth,
                  underline: Container(),
                  items: generateMonthYearList().map((date) {
                    return DropdownMenuItem<DateTime>(
                      value: date,
                      child: Text(
                        "${getMonthNameFromInt(date.month)} ${date.year}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: PRIMARY_BLUE),
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
                          onPressed: () {},
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
                    itemCount: 5,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ReminderItem(
                          inverseStyle: true,
                          data: Reminder(
                              id: "1",
                              name: "Doliprane 50mg",
                              frequency: 2,
                              form: "Pill(s)",
                              imageUrl:
                                  "https://www.medicament.com/20187/doliprane-24-sirop-enfant-100-ml.jpg",
                              intakes: [
                                IntakeData(time: TimeOfDay.now(), dose: 3)
                              ],
                              selectedDays: [
                                1
                              ]));
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