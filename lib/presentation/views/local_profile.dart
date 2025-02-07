import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/privacy_policy.dart';
import 'package:medi_mind/presentation/views/report_screen.dart';
import 'package:medi_mind/presentation/views/settings_screen.dart';
import 'package:medi_mind/presentation/views/widgets/common/logo_name_widget.dart';
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

        Center(
                    child: Container(
                      child: Column(
                        children: [
                          const LogoNameWidget(),
                          Text(
                            'Simplifying your medication routine, \none reminder at a time',
                            style: BLUE_SUBHEADING_TEXT_STYLE,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

        //space
        const SizedBox(height: 40,),

        //options list
        Expanded(
          child: ListView(
              children: [
                ProfileTile(title: 'Report', path: 'assets/icons/Report.svg', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportScreen()));
                },),
                ProfileTile(title: 'Privacy Policy', path: 'assets/icons/Privacy.svg', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
                },),
                ProfileTile(title: 'Settings', path: 'assets/icons/Settings.svg', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
                },),
                ProfileTile(title: 'About Us', path: 'assets/icons/AboutUs.svg', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutDialog()));
                },),
              ],
            ),
        ),



      ],

    );
  }
}