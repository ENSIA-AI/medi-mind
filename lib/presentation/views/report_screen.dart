import 'package:flutter/material.dart';
import 'package:medi_mind/data/dbhelper/reportDbHelper.dart';
import 'package:medi_mind/presentation/views/widgets/Report/progress_bar_chart.dart';
import 'package:medi_mind/presentation/views/widgets/Settings/SettingTile.dart';
import 'package:medi_mind/presentation/views/widgets/common/DayBlob.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/common/progress_circle.dart';
import 'package:medi_mind/presentation/views/widgets/Report/progress_line_chart.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/dates.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarV2(
        pageTitle: "My report",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // The title of the line chart
              Text(
                "Progress over the week:",
                style: BLUE_SUBHEADING_TEXT_STYLE,
              ),
              const SizedBox(height: 16),
              // The progress of the week
              FutureBuilder<List<double>>(
                future: getWeeklyProgress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No progress data available.'));
                  }

                  final weeklyProgress = snapshot.data!;

                  return LineChartProgress(
                    typeOfUse: false,
                    lineChartColor: SECONDARY_BURGUNDY,
                    maxValuesY: 100,
                    values: [
                      const [0, 1, 2, 3, 4, 5, 6],
                      weeklyProgress,
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
// the progress indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder<double>(
                    future: getTodayProgress(), 
                    builder:
                        (BuildContext context, AsyncSnapshot<double> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); 
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); 
                      } else if (snapshot.hasData) {
                        
                        return WidgetMedProgress(
                          type: "Today Progress",
                          dateFormat: DateFormat("dd-MM-yyyy")
                              .format(DateTime.now()), 
                          progressVal:
                              snapshot.data!, 
                        );
                      } else {
                        return const Text(
                            'No data available'); 
                      }
                    },
                  ),
                  const SizedBox(width: 5),
                  FutureBuilder<double>(
                    future: getMonthProgress(), 
                    builder:
                        (BuildContext context, AsyncSnapshot<double> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); 
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return WidgetMedProgress(
                          type: "Month Progress",
                          dateFormat: DateFormat("MMMM yyyy")
                              .format(DateTime.now()), 
                          progressVal:
                              snapshot.data!, 
                        );
                      } else {
                        return const Text(
                            'No data available');
                      }
                    },
                  )
                ],
              ),

              const SizedBox(height: 40),

              Text(
                "Missing dosage over the year:",
                style: BLUE_SUBHEADING_TEXT_STYLE,
              ),
              const SizedBox(height: 16),

              FutureBuilder<List<int>>(
                future:
                    getMonthlyMissedIntakes(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); 
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); 
                  } else if (snapshot.hasData) {
                    return BarChartProgress(
                      typeOfUse: true,
                      barChartColor: PRIMARY_BLUE,
                      maxValuesY: 8,
                      values: [
                        const [
                          0,
                          1,
                          2,
                          3,
                          4,
                          5,
                          6,
                          7,
                          8,
                          9,
                          10,
                          11
                        ], // months
                        snapshot.data!.map((e) => e.toDouble()).toList(), // missed intakes
                      ],
                    );
                  } else {
                    return const Text('No data available'); 
                  }
                },
              ),
              SettingTile(
                title: "Progress By Medication",
                iconPath: const Icon(
                  Icons.bar_chart,
                  color: PRIMARY_BLUE,
                ),
                destination: Scaffold(
                  appBar: const AppBarV2(pageTitle: "Medication Report"),
                  body: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future:
                          getMedicationsWeeklyProgress(), 
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child:
                                  CircularProgressIndicator()); 
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                  'Error: ${snapshot.error}')); 
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text(
                                  'No data available')); 
                        }

                        
                        return ListView.separated(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var medication = snapshot.data![index];
                            return SingleMedicationReport(
                              title: medication['medication'],
                              weeklyProgress: medication[
                                  'weeklyProgress'], 
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SingleMedicationReport extends StatelessWidget {
  final String title;
  final List<double> weeklyProgress; 

  const SingleMedicationReport({
    super.key,
    required this.title,
    required this.weeklyProgress, 
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: PRIMARY_BLUE),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: PRIMARY_BLUE,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: PRIMARY_BLUE,
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "This week",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    7, 
                    (index) {
                      
                      DateTime sunday = DateTime.now()
                          .subtract(Duration(days: DateTime.now().weekday - 1));
                      
                      DateTime dateForDay = sunday.add(Duration(days: index));

                      
                      bool hasPassed = dateForDay.isBefore(DateTime.now());

                      return Row(
                        children: [
                          DayBlobAlt(
                            day: getDayNameFromDate(dateForDay),
                            number: dateForDay.day.toString(),
                            passed:
                                hasPassed, 
                            value: weeklyProgress[
                                index],
                          ),
                          const SizedBox(width: 1.5),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
