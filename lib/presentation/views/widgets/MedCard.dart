import 'package:flutter/material.dart';
import 'package:project/themes/styles.dart';
import 'package:project/themes/colors.dart';

class MedCard extends StatelessWidget {
  const MedCard({super.key, required this.title, required this.subtitle, required this.picpath});

  final String title;
  final String subtitle;
  final String picpath;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:  const EdgeInsets.fromLTRB(20, 10, 10, 10),
      height: 100,
      margin: const EdgeInsets.symmetric(vertical:  6.0, horizontal: 8),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color:PRIMARY_BLUE,
      boxShadow: [  BoxShadow(
        color: const Color.fromARGB(78, 0, 0, 0), // shadow color
        blurRadius: 2, // blur
        offset: const Offset(0, 4), // shadow position
      ),]
      ),
      child: 
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(10),   
                child: Image.asset(picpath, fit: BoxFit.cover , width:70, height: 70,),),
                const SizedBox(width: 30,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( title, style: BEIGE_SUBHEADING_TEXT_STYLE, ),
                       const SizedBox(width: 8,),
                      Text( subtitle, style: WHITE_TEXT_STYLE , ),   
                    ],
                        ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.more_vert, color: const Color.fromARGB(255, 255, 255, 255)),
                  ],
                ),        
                        ],
                      )
               
                      );
                                     }
}