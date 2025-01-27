import 'package:flutter/material.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/presentation/views/widgets/common/DayBlob.dart';
import 'package:medi_mind/presentation/views/widgets/common/logo_name_widget.dart';
import 'package:medi_mind/presentation/views/widgets/Home%20Screen/no_reminder.dart';
import 'package:medi_mind/presentation/views/widgets/Home%20Screen/reminder_details.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/dates.dart';
import 'package:medi_mind/utils/dummy_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/presentation/bloc/home_bloc.dart';

// This page is still using dummy data as the progress is yet to be implemented.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(DbHelper()),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // The logo + slogan
                  Center(
                    child: Container(
                      child: Column(
                        children: [
                          const LogoNameWidget(),
                          Text(
                            'Your health our \npriority',
                            style: BLUE_SUBHEADING_TEXT_STYLE,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // The report of the page
                  InkWell(
                      child: Text('Week Progress:',
                          style: BLUE_SUBHEADING_TEXT_STYLE)),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        7,
                        (index) => Row(
                          children: [
                            DayBlobAlt(
                              day: getDayNameFromDate(state.currentTime
                                  .subtract(Duration(days: (7 - index)))),
                              number: state.currentTime
                                  .subtract(Duration(days: (7 - index)))
                                  .day
                                  .toString(),
                              passed: true,
                              value: state.weekProgress[index],
                            ),
                            const SizedBox(
                              width: 1.5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // The upcoming reminder
                  const SizedBox(height: 50),
                  Text('Today upcoming reminder:',
                      style: BLUE_SUBHEADING_TEXT_STYLE),
                  const SizedBox(height: 10),

                  SingleChildScrollView(
                    child: Column(
                      children: [
                        state.upcomingReminders.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.upcomingReminders.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: MedDetails(
                                      reminderData:
                                          state.upcomingReminders[index],
                                      onDismissed: (String id) {
                                      },
                                    ),
                                  );
                                },
                              )
                            : const NoReminder()
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
