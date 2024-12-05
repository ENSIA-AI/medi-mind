import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';

class DayBlob extends StatelessWidget {
  const DayBlob({
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
