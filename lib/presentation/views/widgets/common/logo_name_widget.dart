import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_mind/themes/styles.dart';

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
        style: LOGO_NAME_TEXT_STYLE,
      )
    ],);
  }
}
