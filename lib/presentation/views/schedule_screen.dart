import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/presentation/bloc/schedule_cubit.dart';
import 'package:medi_mind/presentation/views/widgets/Schedule%20Screen/day_select_tile.dart';
import 'package:medi_mind/presentation/views/widgets/common/reminder_item.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/dates.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScheduleCubit(DbHelper()),
      child: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          final cubit = context.read<ScheduleCubit>();

          // Sort the reminders by time
          final sortedReminders = List.from(state.reminders)
            ..sort((a, b) {
              final timeA = TimeOfDay(
                hour: int.parse(a['time'].split(':')[0]),
                minute: int.parse(a['time'].split(':')[1]),
              );
              final timeB = TimeOfDay(
                hour: int.parse(b['time'].split(':')[0]),
                minute: int.parse(b['time'].split(':')[1]),
              );
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
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: PRIMARY_BLUE),
                        value: state.selectedMonth,
                        underline: Container(),
                        items: cubit.generateMonthYearList().map((date) {
                          return DropdownMenuItem<DateTime>(
                            value: date,
                            child: Row(
                              children: [
                                Text(
                                  "${getMonthNameFromInt(date.month)} ",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: PRIMARY_BLUE),
                                ),
                                Text(
                                  "${date.year}",
                                  style: const TextStyle(
                                      fontSize: 24, color: PRIMARY_BLUE),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: cubit.updateSelectedMonth,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            getLastMonthDayFromDate(state.selectedMonth) -
                                DateTime.now().day +
                                1, (index) {
                          int day = DateTime.now().day + index;

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: DaySelectTile(
                              day: state.selectedDate.copyWith(day: day),
                              isSelected: state.selectedDate.day == day,
                              onTap: (int value) =>
                                  cubit.updateSelectedDay(value),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: PRIMARY_BLUE,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 20.0, top: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("To take",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                )),
                            const Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    elevation: 0,
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    foregroundColor: PRIMARY_BLUE),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/addmed");
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 32,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: sortedReminders.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 0),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Card(
                                  child: ReminderItem_(
                                      inverseStyle: true,
                                      data: sortedReminders[index],
                                      onDismissed: () {
                                        print("dismissed");
                                      }),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
