import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoNameWidget extends StatelessWidget {
  const LogoNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      SvgPicture.asset("assets/icons/app_logo.svg"),
      
      Text("MediMind",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: Color(0xFF031D44)
        ),
      )
    ],);
  }
}
