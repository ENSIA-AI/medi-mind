import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';

class MedicationDetailOption extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  final Function onPressed;
  const MedicationDetailOption({
    super.key, required this.title, required this.description, required this.icon, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: (){onPressed();},
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: PRIMARY_BLUE.withOpacity(0.05)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: icon,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: PRIMARY_BLUE,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      description,
                      style: TextStyle(color: PRIMARY_BLUE),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
