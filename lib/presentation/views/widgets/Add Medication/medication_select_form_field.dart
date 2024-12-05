import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';

class MedicationSelectFormField extends StatelessWidget {
  final List<String> options; // List of options for the dropdown
  final String label; // Label for the field
  final String? selectedValue; // Current selected value
  final Function(String?) onSelect; // Callback to handle selection changes

  const MedicationSelectFormField({
    super.key,
    required this.options,
    required this.label,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Dropdown
        Row(
          children: [
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Your medication must have a unit!";
                      }
                      return null;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: PRIMARY_BLUE,
                    ),
                    isExpanded: true,
                    items: options
                        .map(
                          (option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontFamily: "Spartan League",
                                color: PRIMARY_BLUE,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    value: selectedValue,
                    onChanged: onSelect,
                    borderRadius: BorderRadius.circular(20),
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "League Spartan",
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
