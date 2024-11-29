import 'package:flutter/material.dart';
import 'package:project/themes/styles.dart';
import 'package:project/themes/colors.dart';

//text styles need to be added

class NotificationTile extends StatelessWidget {
   const NotificationTile({super.key, required this.title, required this.time, required this.missed, required this.duration, });

  final String title;
  final String time;
  final bool missed;
  final String duration;
  //Color viewed;
  //Color unviewed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:  const EdgeInsets.fromLTRB(0, 0, 30, 0),
      height: 120,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: .0, horizontal: 0),
        leading: CircleAvatar(
          radius: 50,
          backgroundColor: missed? const Color.fromARGB(255, 196, 32, 32): const Color.fromARGB(255, 111, 158, 69), 
          child: Icon(missed? Icons.close_rounded :Icons.check_circle_outline, color: Colors.white,),   
        ),
      
        title: Text( title,
        style: BLUE_TEXT_STYLE,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.alarm, color:PRIMARY_BLUE, size: 20,),
            SizedBox(width:10),
            Text(this.time,
            style: TextStyle(color: Color.fromRGBO(3, 29,68, 100)),
                 ),
        ]),
        trailing: Text(duration,
        style: TextStyle(
          color: Color.fromRGBO(3, 29,68, 100))
        ),
        //onTap: (){},  //color changing
      
      ),
    );
  }
}