import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/main_app_screen.dart';
import 'package:medi_mind/presentation/views/widgets/common/action_button.dart';
import 'package:medi_mind/presentation/views/widgets/common/logo_name_widget.dart';
import 'package:medi_mind/themes/colors.dart';

import '../../themes/styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:  150.0, bottom: 60),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const LogoNameWidget(),

                  Text("Simplifying your medication routine, one reminder at a time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.2,
                      fontSize: 20, fontWeight: FontWeight.w600, color: PRIMARY_BLUE),),
                ],
              ),


              Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  48.0),
                    child: const Text("Stay on top of your health with MediMind. Manage your medications effortlessly and never miss a dose with personalized reminders.",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          height: 1,
                          color: PRIMARY_BLUE
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  ActionButton(text: "Log In", onPressed: (){} , style: PRIMARY_ACTION_BUTTON_STYLE, textStyle: PRIMARY_ACTION_BUTTON_TEXT_STYLE),
                  SizedBox(height: 10,),
                  ActionButton(text: "Sign Up", onPressed: (){} , style: SECONDARY_ACTION_BUTTON_STYLE, textStyle: SECONDARY_ACTION_BUTTON_TEXT_STYLE),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed('/main');
                          },
                          child: Text("Skip", style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                          ),),
                        ),
                      ],
                    ),
                  )
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}
