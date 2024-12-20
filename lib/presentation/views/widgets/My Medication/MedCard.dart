import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/Medication%20Details%20Pages/medication_details.dart';
import 'package:medi_mind/presentation/views/widgets/common/progress_circle.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/themes/colors.dart';

import 'package:medi_mind/data/model/medication.dart';

class MedCard extends StatelessWidget {
  const MedCard({super.key, required this.medication});

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: PRIMARY_BLUE,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(78, 0, 0, 0), // Shadow color
              blurRadius: 2, // Blur radius
              offset: const Offset(0, 4), // Shadow offset
            ),
          ],
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //medicine picture
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: medication.img != null 
                    ? Image.memory(
                        medication.img !,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      )
                    : Container(
                        width: 70,
                        height: 70,
                        child: Icon(
                          Icons.medication,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
              ),

              const SizedBox(width: 30),

              //text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.name,
                      style: BEIGE_SUBHEADING_TEXT_STYLE,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${medication.unit}',
                      style: WHITE_REGULAR_TEXT_STYLE,
                    ),
                  ],
                ),
              ),

              //three dots
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MedicationDetails(
                      medicationData: medication,
                    ),
                  ));
                },
                child: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ]));
  }
}
