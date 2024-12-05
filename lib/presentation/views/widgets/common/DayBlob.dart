import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';


class DayBlob extends StatelessWidget {

  const DayBlob({super.key, required this.day, required this.number, required this.color, required this.passed});

  final String day;
  final String number;
  final bool passed;
  final Color color;

  @override
Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 95,
      decoration: BoxDecoration(
        color: passed? PRIMARY_BLUE: Colors.grey ,
        borderRadius: BorderRadius.circular(28),
         ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // the day text
          Text(day,
            style: TextStyle(color: Colors.white, fontSize: 18),
               ),
          //space     
          SizedBox(height: 8),
          //the colored circle
          CircleAvatar(
            radius: 20,
            backgroundColor: color,
            child:
              //day text
             Text(
              '$number',
              style: TextStyle(color: Colors.white, fontSize: 18),
                 ),
          ),
        ],
      ),
    );
  }
}