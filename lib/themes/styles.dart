import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';

ButtonStyle PRIMARY_LOGIN_BUTTON_STYLE =
    ElevatedButton.styleFrom(backgroundColor: PRIMARY_BLUE, elevation: 5);

TextStyle PRIMARY_LOGIN_BUTTON_TEXT_STYLE = const TextStyle(
    fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFFFFEAAE));

ButtonStyle SECONDARY_SIGNUP_BUTTON_STYLE =
    ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C0E23), elevation: 5);

TextStyle SECONDARY_SIGNUP_BUTTON_TEXT_STYLE = const TextStyle(
    fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF));

TextStyle WHITE_REGULAR_TEXT_STYLE = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF));

TextStyle BEIGE_SUBHEADING_TEXT_STYLE =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: TEXT_BEIGE);

        
TextStyle LOGO_NAME_TEXT_STYLE = const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: Color(0xFF031D44)
        );