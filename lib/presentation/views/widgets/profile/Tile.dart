import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';


//with circled icons, used in profile

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.title, required this.path, required this.onTap, });

  final String title;
  final String path;
  final VoidCallback onTap;
  //ontap color

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:  EdgeInsets.only(left: 16.0, right: 16.0),
      height: 70,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: 
        ListTile(
          
            leading: CircleAvatar(
                  backgroundColor: PRIMARY_BLUE,
                  child: SvgPicture.asset(
                    path, 
                    color: Colors.white, 
                    width: 24,           
                    height: 24,
                  ),
                ),
            title: Text( title,
            style: BLUE_SUBHEADING_TEXT_STYLE, ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: PRIMARY_BLUE, size:20.0),
            onTap: onTap,  
                ),
                     );
                                     }
}