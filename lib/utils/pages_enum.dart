import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/widgets/common/reminder_item.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/dates.dart';
// This page will be changed Later

const HOMEPAGE_INDEX = 0;
const MEDICATION_PAGE_INDEX = 1;
const SCHEDULE_PAGE_INDEX = 2;
const SETTINGS_PAGE_INDEX = 3;

dynamic PAGES_LIST = [
  ScheduleScreen(),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ReminderItem(
                inverseStyle: true,
                data: Reminder(
                    id: "0",
                    name: "Ibuprofen",
                    frequency: 2,
                    form: "1 Pill",
                    selectedDays: [0],
                    imageUrl:
                        "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
                    intakes: [
                      IntakeData.new(
                          dose: 2, time: TimeOfDay(hour: 8, minute: 20))
                    ]),
              );
            },
          ))
        ],
      ),
    ),
  ),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("This is My Medication !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.add_alert_rounded)
  ]),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("This is My Schedule !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.calendar_month),
  ]),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("This is My Settings !"),
    SizedBox(
      height: 80,
    ),
    Icon(Icons.settings)
  ]),
];

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

class DaySelectTile extends StatelessWidget {
  final DateTime day;
  final Function onTap;
  final bool isSelected;
  const DaySelectTile({
    super.key,
    required this.day,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(day.day);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? PRIMARY_BLUE : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Text("${day.day}",
                style: TextStyle(
                    fontSize: 32,
                    color: !isSelected ? PRIMARY_BLUE : Colors.white,
                    fontWeight: FontWeight.bold)),
            Text("${getDayNameFromDate(day)}",
                style: TextStyle(
                  color: !isSelected ? PRIMARY_BLUE : Colors.white,
                  fontSize: 20,
                ))
          ],
        ),
      ),
    );
  }
}

const List<Map> onBoardingInfo = [
  {
    "imageUrl": "assets/images/onBoarding1.png",
    "title": "Start your journey!",
    "description":
        "MediMind Helps you eat your breakfast, do your SWE homework and most importantly can do simplex"
  },
  {
    "imageUrl": "assets/images/onBoarding2.png",
    "title": "Conquer the world!",
    "description":
        "MediMind Helps you eat your dinner, do your OR quiz and most importantly malia dont read this"
  },
  {
    "imageUrl": "assets/images/onBoarding3.png",
    "title": "Find your goals!",
    "description":
        "MediMind Helps you eat your dinner, do your OR quiz and most importantly malia dont read this"
  }
];
