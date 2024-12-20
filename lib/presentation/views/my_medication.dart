import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/presentation/bloc/medications_bloc.dart';
import 'package:medi_mind/presentation/views/add_medication_form.dart';
import 'package:medi_mind/presentation/views/widgets/My%20Medication/MedCard.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';


class MedicationList extends StatelessWidget {
  const MedicationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicationCubit()..fetchMedications(),
      child: Scaffold(
        // Add button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: SECONDARY_BURGUNDY,
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddMedicationPage()),
            );
          },
          icon: const Icon(Icons.add, color: Colors.white, size: 25),
          label: Text("Add", style: WHITE_SUBHEADING_TEXT_STYLE),
        ),

        // Body with BlocBuilder
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // Title
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  Text('My medication:', style: BLUE_SUBHEADING_TEXT_STYLE),
                ],
              ),
            ),

            // List of medications
            Expanded(
              child: BlocBuilder<MedicationCubit, MedicationState>(
                builder: (context, state) {
                  if (state is MedicationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MedicationLoaded) {
                    if (state.medications.isEmpty) {
                      return const Center(child: Text('No medications found.'));
                    }
                    return ListView.builder(
                      itemCount: state.medications.length,
                      itemBuilder: (_, index) => MedCard(
                        medication: state.medications[index],
                      ),
                    );
                  } else if (state is MedicationError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return const Center(child: Text('No data available.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
