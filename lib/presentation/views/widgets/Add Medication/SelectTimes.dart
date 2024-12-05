import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class MedTimes extends StatelessWidget {
  const MedTimes({
    super.key,
    required this.value,
    required this.imgIndex,
    required this.selectedValue,
    required this.onSelect,
  });

  final String value;
  final int imgIndex;
  final int? selectedValue; // Current selected value passed from the parent
  final Function(int) onSelect; // Callback to update the selected value

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(imgIndex); // Notify parent to update the selected value
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(2, 3, 0, 8),
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // Compare against imgIndex instead of value string
          color: (selectedValue == imgIndex) ? SECONDARY_BURGUNDY : PRIMARY_BLUE,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                "assets/icons/$imgIndex.png",
                height: 50,
                width: 50,
              ),
            ),
            Text(
              value,
              style: WHITE_REGULAR_TEXT_STYLE,
            ),
          ],
        ),
      ),
    );
  }
}
