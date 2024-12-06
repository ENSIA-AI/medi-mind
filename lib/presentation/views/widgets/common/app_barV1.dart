import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/notification_screen.dart';
import 'package:medi_mind/themes/colors.dart';

class AppBarV1 extends StatelessWidget implements PreferredSizeWidget {
  const AppBarV1({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen()));
            },
            child: const Icon(
              Icons.notifications_rounded,
              size: 24,
              color: PRIMARY_BLUE,
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: GestureDetector(
              onTap: () {
                debugPrint("Settings icon tapped");
              },
              child: const Icon(
                Icons.settings,
                size: 24,
                color: PRIMARY_BLUE,
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
