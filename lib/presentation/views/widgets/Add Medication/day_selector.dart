import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/widgets/common/DayBlob.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class DaySelector extends StatelessWidget {
  const DaySelector({
    Key? key,
    required this.selectedDays,
    required this.onDaysSelected,
    this.containerWidth = 60,
    this.containerHeight = 80,
  }) : super(key: key);

  final Set<int> selectedDays;
  final ValueChanged<Set<int>> onDaysSelected;  // Callback to notify parent
  final double containerWidth;
  final double containerHeight;

  static const List<String> _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Wrap(
          spacing: 5.0,
          runSpacing: 8.0,
          children: List.generate(
            7,
            (index) => GestureDetector(
              onTap: () {
                // Toggle the day selection
                if (selectedDays.contains(index)) {
                  onDaysSelected({...selectedDays}..remove(index));
                } else {
                  onDaysSelected({...selectedDays}..add(index));
                }
              },
              child: DayBlob(
                day: _dayNames[index],
                number: "",
                color: selectedDays.contains(index)
                    ? Colors.amber.shade400
                    : Colors.white,
                passed: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
