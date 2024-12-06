import 'package:flutter/material.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/views/medication_detail_screen.dart';
import 'package:medi_mind/data/model/medication.dart';



class MedCard extends StatelessWidget {
  const MedCard({
    super.key,
    required this.medication
  });

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
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
            child: Image.asset(
              medication.picpath,
              fit: BoxFit.cover,
              width: 70,
              height: 70,
            ),
          ),

          const SizedBox(width: 30),

         //text
          Expanded(
            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication.name,
                  style: BEIGE_SUBHEADING_TEXT_STYLE,
                ),
                const SizedBox(height: 8),
                Text(
                  '${medication.type}  ${medication.dose}',
                  style: WHITE_REGULAR_TEXT_STYLE,
                ),
              ],
            ),
          ),

          //three dots 
          InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, 
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255), 
                      builder: (context) {
                        return MedicineDetails(medobj: medication);}, //return the associated medication detail page
                        );
                      },
                  child: const Icon(Icons.more_vert, color: Colors.white),
                ),
              ]
            )
          );
  }
}