import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/presentation/bloc/bottom_nav_bloc.dart';
import 'package:medi_mind/presentation/views/widgets/bottom_nav_item.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/pages_enum.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  final topLevelPages = PAGES_LIST;

  late PageController _currentPageController;

  @override
  void initState() {
    super.initState();
    _currentPageController = PageController();
  }

  @override
  void dispose() {
    _currentPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              iconSize: 40,
              unselectedIconTheme: const IconThemeData(color: PRIMARY_BLUE),
              selectedIconTheme: const IconThemeData(color: SECONDARY_RED),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: BlocProvider.of<BottomNavCubit>(context).state,
              onTap: (value) {
                BlocProvider.of<BottomNavCubit>(context)
                    .changeSelectedPage(value);
                _currentPageController.animateToPage(value,
                    curve: Curves.bounceIn,
                    duration: const Duration(milliseconds: 200));
              },
              items: [
                BottomNavBarItem(context, "assets/icons/Home.svg", "Home", HOMEPAGE_INDEX,
                    PRIMARY_BLUE, SECONDARY_RED),
                BottomNavBarItem(context, "assets/icons/Pill.svg",
                    "My Medications", MEDICATION_PAGE_INDEX, PRIMARY_BLUE, SECONDARY_RED),
                BottomNavBarItem(context, "assets/icons/Calendar.svg",
                    "Schedule", SCHEDULE_PAGE_INDEX, PRIMARY_BLUE, SECONDARY_RED),
                BottomNavBarItem(context, "assets/icons/Person.svg", "Settings",
                    SETTINGS_PAGE_INDEX, PRIMARY_BLUE, SECONDARY_RED)
              ]),
          body: Center(
            child: PageView(
                onPageChanged: (value) {
                  BlocProvider.of<BottomNavCubit>(context)
                      .changeSelectedPage(value);
                },
                controller: _currentPageController,
                children: topLevelPages),
          ),
        );
      },
    );
  }
}
