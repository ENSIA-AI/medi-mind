import 'package:flutter/material.dart';
import 'package:project/themes/colors.dart';
import 'package:project/themes/styles.dart';


class MedTimingTile extends StatelessWidget {
  const MedTimingTile({super.key, required this.title, required this.subtitle });

  final String title;
  final String subtitle;
  //ontap color

  @override
  Widget build(BuildContext context) {

   return  Container(
      alignment: Alignment.center,
      padding:  const EdgeInsets.fromLTRB(2, 3, 0, 8),
      margin: const EdgeInsets.symmetric(vertical:  6.0, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color:PRIMARY_BLUE,
      ),
      child: 
        ListTile(
            title: Text( title,
            style: BEIGE_SUBHEADING_TEXT_STYLE, ),
            subtitle: Text( subtitle,
            style: WHITE_TEXT_STYLE,
             ),
           dense: true,
            //onTap: (){},  
                ),
                     );
}
}