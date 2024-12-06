import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class AppBarV2 extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;

  const AppBarV2({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GestureDetector(
          onTap: () {
            debugPrint("Go back icon tapped");
            Navigator.pop(context); // Navigate back
          },
          child: const Icon(
            Icons.arrow_back_ios, 
            size: 30, 
            color: PRIMARY_BLUE,
          ),
        ),
      ),
      title: Text(
        pageTitle,
        style: BLUE_SUBHEADING_TEXT_STYLE,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}