import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/presentation/views/widgets/common/DayBlob.dart';
import 'package:medi_mind/presentation/views/widgets/common/logo_name_widget.dart';
import 'package:medi_mind/presentation/views/widgets/Home%20Screen/no_reminder.dart';
import 'package:medi_mind/presentation/views/widgets/Home%20Screen/reminder_details.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/dates.dart';
import 'package:medi_mind/utils/dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime current_time = DateTime.now();
  List<Reminder> upcoming_reminders_list = [
    Reminder(
    id: "0",
    name: "Ibuprofen",
    selectedDays: [0,1],
    frequency: 2,
    form: "Pill(s)",
    imageUrl: "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
    intakes: [IntakeData(dose: 1, time: TimeOfDay.now())]
    ),
    Reminder(
    id: "1",
    name: "Ibuprofen",
    selectedDays: [0,1],
    frequency: 2,
    form: "Pill(s)",
    imageUrl: "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
    intakes: [IntakeData(dose: 1, time: TimeOfDay.now())]
    )
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Center(
          child: SingleChildScrollView(
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
                InkWell(child: Text('Week Progress:', style: BLUE_SUBHEADING_TEXT_STYLE)),
                const SizedBox(height: 10),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      7,
                      (index) => Row(
                        children: [
                          DayBlobAlt(
                            day: getDayNameFromDate(current_time.subtract(Duration(days: (7 - index)))),
                            number: current_time.subtract(Duration(days: (7 - index))).day.toString(),
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
                ),
                // The upcoming reminder
                const SizedBox(height: 50),
                Text('Today upcoming reminder:',
                    style: BLUE_SUBHEADING_TEXT_STYLE),
                const SizedBox(height: 10),

                SingleChildScrollView(
                  child:  Column(
                    children: [
                      upcoming_reminders_list.length > 0 ? 
                      MedDetails(medREminder: upcoming_reminders_list[0], onDismissed: (String id){
                        upcoming_reminders_list.removeWhere((item) => item.id == id);
                        setState(() {
                          
                        });
                      },)
                      :
                      NoReminder()
                    ],
                  ),
                ),

                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
