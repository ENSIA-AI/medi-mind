import 'package:flutter/material.dart';
import 'package:medi_mind/data/dummy_data.dart';
import 'package:medi_mind/presentation/views/widgets/DayBlob.dart';
import 'package:medi_mind/presentation/views/widgets/logo_name_widget.dart';
import 'package:medi_mind/presentation/views/widgets/no_reminder.dart';
import 'package:medi_mind/presentation/views/widgets/reminder_details.dart';
import 'package:medi_mind/themes/styles.dart';

class PartientHome extends StatelessWidget {
  const PartientHome({super.key});

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
                Text('Your Schedule:', style: BLUE_SUBHEADING_TEXT_STYLE),
                const SizedBox(height: 10),
                // Generate DayBlob widgets for 7 days
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      7,
                      (index) => Row(
                        children: [
                          DayBlob(
                            day: days[index],
                            number: valuesD[index],
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
                const SizedBox(height: 20),
                Text('Today upcoming reminder:',
                    style: BLUE_SUBHEADING_TEXT_STYLE),
                const SizedBox(height: 10),

                SizedBox(
                  height: 170,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MedDetails(medREminder: rem1),
                        MedDetails(medREminder: rem2),
                        const NoReminder(),
                      ],
                    ),
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
