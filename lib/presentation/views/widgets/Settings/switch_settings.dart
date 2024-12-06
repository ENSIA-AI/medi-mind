
import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class SwitchTile extends StatelessWidget {
  final String title;
  final bool boolValue;
  final ValueChanged<bool> onChanged;

  const SwitchTile({
    Key? key,
    required this.title,
    required this.boolValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title, style: BLUE_TEXT_STYLE),
        trailing: Transform.scale(
          scale: 0.7, 
          child: Switch(
            value: boolValue,
            onChanged: onChanged,
            activeColor: Colors.white, 
            activeTrackColor: PRIMARY_BLUE, 
            inactiveThumbColor: PRIMARY_BLUE,
            inactiveTrackColor: Colors.transparent, 
          ),
        ),
      ),
    );
  }
}
