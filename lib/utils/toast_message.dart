import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medi_mind/themes/colors.dart';

void ShowToastMessage(String message){
  Fluttertoast.showToast(
        msg: message,
        fontAsset: "assets/fonts/LeagueSpartan-Regular.ttf",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: PRIMARY_BLUE,
        textColor: Colors.white,
        fontSize: 16.0
    );
}