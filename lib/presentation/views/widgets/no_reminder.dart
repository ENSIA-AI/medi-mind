import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';

class NoReminder extends StatelessWidget {
  const NoReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      height: 160,
      decoration: const BoxDecoration(
        color: PRIMARY_BLUE,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: const Center(
          // fix it in the middle
          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
                    children: [
            Icon(
              Icons.notifications_none,
              size: 50,
              color: TEXT_BEIGE,
            ),
            SizedBox(height: 10),
            Text(
              "No upcoming reminder for the day",
              style: TextStyle(color: TEXT_BEIGE, fontSize: 20 , fontWeight:FontWeight.w600),
            ),SizedBox(height: 10),
                    ],
                  ),
          )
          ),
    );
  }
}
