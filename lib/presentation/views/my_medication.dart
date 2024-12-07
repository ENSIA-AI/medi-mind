import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/add_medication_form.dart';
import 'package:medi_mind/presentation/views/widgets/My Medication/MedCard.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/themes/colors.dart';

class MedicationList extends StatelessWidget {
  const MedicationList({super.key, required this.meds});

  final List<Medication> meds; //list of medication objects

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // the add button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:FloatingActionButton.extended(
                                                        backgroundColor: SECONDARY_BURGUNDY,
                                                        foregroundColor: Colors.white,
                                                        elevation: 5,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(30),
                                                                                     ),
                                                        onPressed: () {
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMedicationPage()));
                                                        }, //navigate to the add medication page
                                                        icon: const Icon(Icons.add, color: Colors.white, size: 25),
                                                        label:  Text("Add", style: WHITE_SUBHEADING_TEXT_STYLE,),
                                                      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //space
            const SizedBox(height: 30),

            // title
            Padding(
              padding: EdgeInsets.fromLTRB(20 ,0, 0,0),
              child: Row(children: [Text('My medication:', style: BLUE_SUBHEADING_TEXT_STYLE)])
                   ),
                
          
            // List of medications
            Expanded(
              
              child: ListView.builder(
                itemCount: meds.length,
                itemBuilder: (_, index) => MedCard(medication: meds[index]), //creating medication card for the each item in the list
                                     ),
                    ),
      
                    ]
        
          ),
       );
  }
}

  
