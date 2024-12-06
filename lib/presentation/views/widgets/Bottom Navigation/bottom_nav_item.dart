import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_mind/themes/colors.dart';

BottomNavigationBarItem BottomNavBarItem(
  BuildContext context,
  String iconPath,
  String label,
  int pageIndex,
  Color unSelectedColor,
  Color selectedColor,
) {
  return BottomNavigationBarItem(
      label: label,
      
      icon: SvgPicture.asset(iconPath, color: PRIMARY_BLUE, height: 28, width: 28,),
      activeIcon: Column(
        children: [
          SvgPicture.asset(iconPath, color: SECONDARY_RED, height: 28, width: 28,),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 3,
            width: 28,
            decoration: BoxDecoration(
                color: SECONDARY_RED, borderRadius: BorderRadius.circular(20)),
          )
        ],
      ));
}
