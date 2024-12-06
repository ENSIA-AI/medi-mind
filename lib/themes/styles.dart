import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';

ButtonStyle PRIMARY_ACTION_BUTTON_STYLE =
    ElevatedButton.styleFrom(
        
        backgroundColor: PRIMARY_BLUE, elevation: 5);

TextStyle PRIMARY_ACTION_BUTTON_TEXT_STYLE = const TextStyle(
    fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFFFFEAAE));

ButtonStyle SECONDARY_ACTION_BUTTON_STYLE =
    ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C0E23), elevation: 5);

TextStyle SECONDARY_ACTION_BUTTON_TEXT_STYLE = const TextStyle(
    fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF));

TextStyle WHITE_REGULAR_TEXT_STYLE = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF));

TextStyle BLUE_REGULAR_TEXT_STYLE = const TextStyle(
  fontSize: 20, fontWeight: FontWeight.w400, color: PRIMARY_BLUE
);

TextStyle BEIGE_SUBHEADING_TEXT_STYLE =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: TEXT_BEIGE);

        
TextStyle LOGO_NAME_TEXT_STYLE = const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: Color(0xFF031D44)
        );

Color TRANSPARENT_BG = const Color.fromARGB(40, 3, 29, 68);

TextStyle DETAILS_TEXT = const TextStyle(
    fontSize: 30, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 255, 233, 174));

TextStyle DETAILS_ALARM = const TextStyle(
    fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white);

TextStyle DETAILS_SEE_MORE = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 233, 174));

ButtonStyle GREEN_NOTIFICATION_BTN = ElevatedButton.styleFrom(
    backgroundColor: Colors.green, elevation: 5);

ButtonStyle RED_NOTIFICATION_BTN = ElevatedButton.styleFrom(
    backgroundColor:  Colors.red, elevation: 5);

// mainly used for headers
TextStyle BLUE_SUBHEADING_TEXT_STYLE = const TextStyle(
    fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF031D44));

TextStyle BLACK_REGULAR_TEXT_STYLE = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);

// smaller version 
TextStyle REGULAR_TEXT_STYLE_WHITE = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white );

// normal text style
TextStyle BLUE_TEXT_STYLE = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF031D44));

