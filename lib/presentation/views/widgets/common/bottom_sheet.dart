import 'package:flutter/material.dart';
import 'package:medi_mind/themes/styles.dart';

 

class BottomDialog extends StatelessWidget {
  // will be changed for the delete account or log out 
  final String typeOfDialog;
  final String textOfBottomSheet;
  final String leftBtn;
  final String rightBtn;

  const BottomDialog({
    super.key,
    required this.typeOfDialog,
    required this.textOfBottomSheet,
    required this.leftBtn,
    required this.rightBtn,
  });

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    barrierColor: TRANSPARENT_BG,
      builder: (BuildContext context) {
        return Container(
          height: 242,
          width: 360,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text(
                typeOfDialog,
                style:BLUE_SUBHEADING_TEXT_STYLE,
              ),),
              const SizedBox(height: 20),
              Text(
                textOfBottomSheet,
                style: BLACK_REGULAR_TEXT_STYLE,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("pressed $leftBtn");
                    },
                    style: SECONDARY_ACTION_BUTTON_STYLE,
                    child: Text(leftBtn , style: WHITE_REGULAR_TEXT_STYLE,),
                  ),
                  ElevatedButton(
                    onPressed: () {
                     print("pressed $rightBtn");
                    },
                    style : PRIMARY_ACTION_BUTTON_STYLE,
                    child: Text(rightBtn ,style: WHITE_REGULAR_TEXT_STYLE,)
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(// will be changed later to a text + icon to call it 
      child: ElevatedButton(
        onPressed: () => _showBottomSheet(context),
        child: const Text('Show Bottom Sheet'),
      ),
    );
  }
}
