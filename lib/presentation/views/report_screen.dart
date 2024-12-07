import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/widgets/Report/progress_bar_chart.dart';
import 'package:medi_mind/presentation/views/widgets/Settings/SettingTile.dart';
import 'package:medi_mind/presentation/views/widgets/common/DayBlob.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/common/progress_circle.dart';
import 'package:medi_mind/presentation/views/widgets/Report/progress_line_chart.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/dates.dart';
import 'package:medi_mind/utils/dummy_data.dart';

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
              const LineChartProgress(
                typeOfUse: false,
                lineChartColor: SECONDARY_BURGUNDY,
                maxValuesY: 100,
                values: [
                  [0, 1, 2, 3, 4, 5, 6],
                  [10, 20, 50, 80, 70, 40, 30],
                ],
              ),
              const SizedBox(height: 30),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WidgetMedProgress(
                      type: "Today Progress",
                      dateFormat: "11-11-2024",
                      progressVal: 0.75),
                  SizedBox(width: 5),
                  WidgetMedProgress(
                      type: "Month Progress",
                      dateFormat: "November 2024",
                      progressVal: 0.5),
                ],
              ),
              const SizedBox(height: 40),

              Text(
                "Missing dosage over the year:",
                style: BLUE_SUBHEADING_TEXT_STYLE,
              ),
              const SizedBox(height: 16),

              const BarChartProgress(
                typeOfUse: true,
                barChartColor: PRIMARY_BLUE,
                maxValuesY: 8,
                values: [
                  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                  [2, 2, 3, 5, 4, 8, 2, 6, 0, 0, 0, 0, 0],
                ],
              ),
              SettingTile(
                  title: "Progress By Medication",
                  iconPath: Icon(
                    Icons.bar_chart,
                    color: PRIMARY_BLUE,
                  ),
                  destination: Scaffold(
                    appBar: AppBarV2(pageTitle: "Medication Report"),
                    body: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: ListView.separated(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return SingleMedicationReport(title: ["Paracetamol (1g)", "Aspirin (1g)", "Cough Syrup (200mg)", "Lorotadin (500mg)", "Insulin "][index],);
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class SingleMedicationReport extends StatelessWidget {
  final String title;
  const SingleMedicationReport({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: PRIMARY_BLUE),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: PRIMARY_BLUE,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: PRIMARY_BLUE,
                  )
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical:  10.0),
                child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:  10.0),
                          child: Text("This week", style: TextStyle(color: Colors.grey),),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
              ),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    7,
                    (index) => Row(
                      children: [
                        DayBlobAlt(
                          day: getDayNameFromDate(
                              DateTime.now().subtract(
                                  Duration(
                                      days: (7 -
                                          index)))),
                          number: DateTime.now()
                              .subtract(Duration(
                                  days: (7 - index)))
                              .day
                              .toString(),
                          passed: valuesP[index],
                          value: valuesC[index],
                        ),
                        const SizedBox(
                          width: 1.5,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
