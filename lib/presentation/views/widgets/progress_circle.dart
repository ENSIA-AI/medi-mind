import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WidgetMedProgress extends StatelessWidget {
  final String type;
  final String dateFormat;
  final double progressVal;
  const WidgetMedProgress({
    super.key,
    required this.type,
    required this.dateFormat,
    required this.progressVal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Medium width
      height: 180, // Medium height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14), // Slightly rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type,
              style: const TextStyle(
                fontSize: 18, // Moderately reduced size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4), // Moderate spacing
            Text(
              dateFormat,
              style: const TextStyle(
                fontSize: 16, // Readable size
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10), // Adequate spacing
            MedProgress(progressValue: progressVal),
          ],
        ),
      ),
    );
  }
}

class MedProgress extends StatefulWidget {
  final double progressValue;

  const MedProgress({super.key, required this.progressValue});

  @override
  State<MedProgress> createState() => _MedProgressState();
}

class _MedProgressState extends State<MedProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.progressValue,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ))..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 55, // Balanced radius
      lineWidth: 9, // Moderate line width
      percent: _progressAnimation.value,
      progressColor: _getProgressColor(_progressAnimation.value),
      circularStrokeCap: CircularStrokeCap.round,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_convertToPercentage(_progressAnimation.value)}%',
            style: const TextStyle(
              fontSize: 26, // Slightly reduced for compactness
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Complete",
            style: TextStyle(
              fontSize: 14, // Moderate size for labels
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

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
