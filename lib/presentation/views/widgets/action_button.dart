import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle style;
  final TextStyle textStyle;
  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.style,
    required this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
          child: Text(
            text,
            style: textStyle,
          ),
        ));
  }
}