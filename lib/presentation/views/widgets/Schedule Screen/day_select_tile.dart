import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/dates.dart';

class DaySelectTile extends StatelessWidget {
  final DateTime day;
  final Function onTap;
  final bool isSelected;
  const DaySelectTile({
    super.key,
    required this.day,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(day.day);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? PRIMARY_BLUE : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Text("${day.day}",
                style: TextStyle(
                    fontSize: 32,
                    color: !isSelected ? PRIMARY_BLUE : Colors.white,
                    fontWeight: FontWeight.bold)),
            Text("${getDayNameFromDate(day)}",
                style: TextStyle(
                  color: !isSelected ? PRIMARY_BLUE : Colors.white,
                  fontSize: 20,
                ))
          ],
        ),
      ),
    );
  }
}
