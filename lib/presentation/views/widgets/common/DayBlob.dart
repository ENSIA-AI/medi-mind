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
      
      decoration: BoxDecoration(
        color: passed? PRIMARY_BLUE: Colors.grey ,
        borderRadius: BorderRadius.circular(28),
         ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              radius: 15,
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
      ),
    );
  }
}


class DayBlobAlt extends StatelessWidget {
  const DayBlobAlt({
    super.key,
    required this.day,
    required this.number,
    required this.value,
    required this.passed,
  });

  final String day;
  final String number;
  final bool passed;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 75,
      decoration: BoxDecoration(
        color: PRIMARY_BLUE,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 3),
          CircleAvatar(
            radius: 17.5,
            backgroundColor: _getColor(value, passed),
            child: Center(
              child: Text(
                number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color _getColor(double value, bool pass) {
    if (!pass) {
      return const Color.fromARGB(255, 174, 198, 207);
    } else {
      if (value < 0.4) {
        return const Color.fromARGB(255, 255, 105, 97);
      } else if (value < 0.7) {
        return const Color.fromARGB(255, 255, 179, 71);
      } else {
        return const Color.fromARGB(255, 119, 221, 119);
      }
    }
  }
}
