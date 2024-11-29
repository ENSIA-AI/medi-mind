import 'package:flutter/material.dart';
import 'package:project/themes/styles.dart';
import 'package:project/themes/colors.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({super.key, required this.title, required this.iconPath });

  final String title;
  final String iconPath;
  //ontap color

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:  EdgeInsets.all(15),
      height: 90,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: 
        ListTile(
            leading: SvgPicture.asset(iconPath, color: PRIMARY_BLUE, size: 30),
            title: Text( title,
            style: BLUE_REGULAR_TEXT_STYLE, ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: PRIMARY_BLUE),
            //onTap: (){},  
                ),
                     );
                                     }
}