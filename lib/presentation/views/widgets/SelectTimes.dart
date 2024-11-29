import 'package:flutter/material.dart';
import 'package:project/themes/colors.dart';
import 'package:project/themes/styles.dart';



class MedTimes extends StatefulWidget {
   MedTimes({super.key, required this.title, required this.imgpath});

  String title;
  String imgpath;
  //final Function(String) onTap;  //highlighitng the clicked container

  @override
  _MedTimesState createState() => _MedTimesState();
}

class _MedTimesState extends State<MedTimes> {
  bool _isHighlighted = false; // Tracks if the container is clicked

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        setState(){};

          _isHighlighted = !_isHighlighted; // Toggle highlight on tap
        //widget.onTap(widget.title); // Store the title using the callback
      },
      child: Container(
        alignment: Alignment.center,
        height: 180,
        width: 180,
        padding: const EdgeInsets.fromLTRB(2, 3, 0, 8),
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _isHighlighted ? SECONDARY_BURGUNDY : PRIMARY_BLUE, // Change color on highlight
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              widget.imgpath,
              width: 110,
              height: 110,
            ),
            SizedBox(height: 15),
            Text(
              widget.title,
              style: WHITE_REGULAR_TEXT_STYLE,
            ),
          ],
        ),
      ),
    );
  }
}
