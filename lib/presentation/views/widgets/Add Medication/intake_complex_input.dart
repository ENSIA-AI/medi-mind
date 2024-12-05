import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/themes/colors.dart';

class IntakeComplexInput extends StatelessWidget {
  final int index;
  final TimeOfDay time;
  final int dose;
  final String unit;
  final Function(TimeOfDay) onTimeChanged;
  final Function(int) onDoseChanged;
  final String label;

  const IntakeComplexInput({
    super.key,
    required this.index,
    required this.time,
    required this.dose,
    required this.unit,
    required this.onTimeChanged,
    required this.onDoseChanged,
    required this.label,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time, // Pass the time directly
    );
    if (picked != null && picked != time) {
      onTimeChanged(picked); // Use the callback to update the time
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Time",
                style: TextStyle(
                  fontSize: 24,
                  color: PRIMARY_BLUE,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () => _selectTime(context),
                child: Row(
                  children: [
                    Text(
                      "${time.hour}:${time.minute < 10 ? "0" : ""}${time.minute}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_BLUE,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.access_time, color: PRIMARY_BLUE),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dose",
                style: TextStyle(fontSize: 24, color: PRIMARY_BLUE),
              ),
              Row(
                children: [
                  InputQty.int(
                    minVal: 1,
                    initVal: dose,
                    decoration: QtyDecorationProps(
                      isBordered: false,
                      plusBtn: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PRIMARY_BLUE,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      minusBtn: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PRIMARY_BLUE,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onQtyChanged: (newDose) {
                      onDoseChanged(newDose);  // Use the callback to update the dose
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    unit,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

