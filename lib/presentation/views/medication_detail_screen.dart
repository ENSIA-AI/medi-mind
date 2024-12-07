import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/themes/colors.dart';


//details page
class MedicineDetails extends StatelessWidget {

  final Medication medobj;

  const MedicineDetails({
                          required this.medobj
                       });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      decoration: const BoxDecoration(
        color: PRIMARY_BLUE,
        borderRadius: BorderRadius.vertical( top: Radius.circular(25.0),), ),
     
      child: Column(
        children: [
          //space
          const SizedBox(height: 10,),
      
          //the arrow at top
          GestureDetector(
            onTap: () => Navigator.pop(context), // Close the bottom sheet
            child: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 50,),
                         ),
      
          //space            
          const SizedBox(height: 20),
      
          //medication name
          Text(
            medobj.name,
            style: SECONDARY_ACTION_BUTTON_TEXT_STYLE
              ),
      
          //space
          const SizedBox(height: 16),
      
          //image
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                medobj.imgPath ?? "",
                fit: BoxFit.cover,
                width: 190,
                height: 190,
              ),
            ),
      
          //space
          const SizedBox(height: 16),
      
          //subtitle: dose and type
          Text(
            "Type: ${medobj.unit}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
      
          //space
          const SizedBox(height: 16),
      
          //details for the medication
          Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment.center,
            child: 
            Column(
              children: [
      
                //title
                Align(
                  alignment: Alignment.centerLeft,
                  child:  Text(
                    "Details",
                    style: WHITE_REGULAR_TEXT_STYLE
                              ),
                      ),
              
                //space
                const SizedBox(height: 8),
      
                //details
                Text(
                      medobj.details ?? "No details available",
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                     ),
              ],),
          )
        ]),
    );
      }
    }
