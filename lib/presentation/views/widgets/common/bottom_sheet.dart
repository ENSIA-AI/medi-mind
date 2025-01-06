import 'package:flutter/material.dart';
import 'package:medi_mind/themes/styles.dart';




void showCustomBottomSheet(BuildContext context, typeOfDialog, textOfBottomSheet, leftBtn, rightBtn, {leftBtnAction = null}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    barrierColor: TRANSPARENT_BG,
      builder: (BuildContext context) {
        return BottomDialog(typeOfDialog: typeOfDialog, textOfBottomSheet: textOfBottomSheet, leftBtn: leftBtn, rightBtn: rightBtn, leftBtnAction: leftBtnAction);
      },
    );
  }

class BottomDialog extends StatelessWidget {
  // will be changed for the delete account or log out 
  final String typeOfDialog;
  final String textOfBottomSheet;
  final String leftBtn;
  final String rightBtn;
  final Function? leftBtnAction;

  const BottomDialog({
    super.key,
    required this.typeOfDialog,
    required this.textOfBottomSheet,
    required this.leftBtn,
    required this.rightBtn,
    this.leftBtnAction,
  });

  

  @override
  Widget build(BuildContext context) {
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
                      if(leftBtnAction != null) leftBtnAction!();
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
  }
}
