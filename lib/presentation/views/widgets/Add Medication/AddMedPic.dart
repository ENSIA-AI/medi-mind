import 'package:flutter/material.dart';

class AddMedicationPic extends StatefulWidget {



  @override
  _AddMedicationPicState createState() => _AddMedicationPicState();

}

class _AddMedicationPicState extends State<AddMedicationPic> {

  
  //variable to store the picked image

  void addImage(){}  //for picking the image and storing it

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(

              children: [
                //the picture
                 Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                     image: AssetImage('fillerimgpath'), // Your image path
                     fit: BoxFit.fill, // Scale the image to cover the container
                     ),
                  ),
                  ),
                  
                //the edit icon
                Positioned(
                  bottom: -8,   //the distance between the buttom edge of the stack and the buttom of the widget
                  right: -8,
                  child: IconButton(onPressed: addImage, 
                  icon: Image.asset('pathtotheediticon',  //edit icon path
                  height: 34,
                  width: 34,
                  fit: BoxFit.fill,
                  ),
                
                  )
                ),
              ],
            ),
            SizedBox(height: 14),
          Text("add picture",
                style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                ),
              ),
    ]        ),
          
        ),

        backgroundColor: const Color.fromARGB(255, 8, 53, 122), // Match background color
    );}}