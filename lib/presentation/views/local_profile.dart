import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/privacy_policy.dart';
import 'package:medi_mind/presentation/views/report_screen.dart';
import 'package:medi_mind/presentation/views/settings_screen.dart';
import 'package:medi_mind/presentation/views/widgets/profile/action_button.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/presentation/views/widgets/profile/Tile.dart';


class LocalProfile extends StatelessWidget {
  const LocalProfile({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        //space 
        const SizedBox(height: 50,),

        //text
        Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          child: Text(
            'Sign Up Or Log In To MedMind And Unlock More Features To Stay On Top Of Your Health',
            textAlign: TextAlign.center,
            style: TextStyle( fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF031D44) ),
                     ),
        ),

        //space 
        const SizedBox(height: 10,),

        //buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionButton(text: 'Log In', onPressed: (){}, style: PRIMARY_ACTION_BUTTON_STYLE, textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFFFEAAE))),
            ActionButton(text: 'Sign Up', onPressed: (){}, style: SECONDARY_ACTION_BUTTON_STYLE, textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF)))
          ],
        ),

        //space
        SizedBox(height: 20,),

        //options list
        Expanded(
          child: ListView(
              children: [
                ProfileTile(title: 'Report', path: 'assets/icons/Report.svg', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportScreen()));
                },),
                ProfileTile(title: 'Privacy Policy', path: 'assets/icons/Privacy.svg', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },),
                ProfileTile(title: 'Settings', path: 'assets/icons/Settings.svg', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
                },),
                ProfileTile(title: 'About Us', path: 'assets/icons/AboutUs.svg', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutDialog()));
                },),
              ],
            ),
        ),



      ],

    );
  }
}