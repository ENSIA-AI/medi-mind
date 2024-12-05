import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';



class WidgetMedProgress extends StatelessWidget {
  final String type;
  final String dateFormat;
  final double progressVal;
  const WidgetMedProgress(
      {super.key, required this.type, required this.dateFormat , required this.progressVal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 197,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(type,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2), // Add spacing between texts
            Text(dateFormat,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            const SizedBox(height: 8), // Add spacing before the progress indicator
            MedProgress(progressValue: progressVal)
          ],
        ),
      ),
    );
  }
}

class MedProgress extends StatefulWidget {
  //progressValue double between 0 to 1
  final double progressValue;

  const MedProgress({super.key, required this.progressValue});

  @override
  State<MedProgress> createState() => _MedProgressState();
}

class _MedProgressState extends State<MedProgress> {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60,
      lineWidth: 10,
      percent: widget.progressValue,
      progressColor: _getProgressColor(widget.progressValue),
      circularStrokeCap: CircularStrokeCap.round,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Text(
            '${_convertToPercentage(widget.progressValue)}%', 
            style: const TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold, 
            ),
          ),
          const Text(
            "Complete", 
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w500, 
            ),
          ),
        ],
      ),
    );
  }
}


//define depending on a threshold the color of the progress indicator
Color _getProgressColor(double progressValue) {
  if (progressValue < 0.4) {
    return Colors.red;
  } else if (progressValue < 0.7) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}

String _convertToPercentage(double progressValue) {
  return (progressValue * 100).toStringAsFixed(0);
}
