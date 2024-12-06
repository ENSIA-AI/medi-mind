import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';


class SettingTile extends StatelessWidget {
  const SettingTile({super.key, required this.title, required this.iconPath ,     required this.destination, });

  final String title;
  final Icon iconPath;
  final Widget destination; 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:  const EdgeInsets.all(8),
      height: 90,
      //color: const Color.fromARGB(255, 255, 255, 255),
      child: 
        ListTile(
            leading: iconPath,
            title: Text( title,
            style: BLUE_TEXT_STYLE, ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, color: PRIMARY_BLUE , size: 20,),
            onTap: () {
          // Navigate to the destination page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }, 
                ),
                     );
                                     }
}