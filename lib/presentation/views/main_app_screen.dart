import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/presentation/bloc/bottom_nav_bloc.dart';
import 'package:medi_mind/presentation/views/widgets/Bottom%20Navigation/bottom_nav_item.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV1.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/pages_enum.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarV1(),
          bottomNavigationBar: BottomNavigationBar(
            unselectedIconTheme: const IconThemeData(color: PRIMARY_BLUE),
            selectedIconTheme: const IconThemeData(color: SECONDARY_RED),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: state,
            onTap: (value) {
              context.read<BottomNavCubit>().changeSelectedPage(value);
              pageController.animateToPage(
                value,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 200),
              );
            },
            items: [
              BottomNavBarItem(
                context,
                "assets/icons/Home.svg",
                "Home",
                HOMEPAGE_INDEX,
                PRIMARY_BLUE,
                SECONDARY_RED,
              ),
              BottomNavBarItem(
                context,
                "assets/icons/Pill.svg",
                "My Medications",
                MEDICATION_PAGE_INDEX,
                PRIMARY_BLUE,
                SECONDARY_RED,
              ),
              BottomNavBarItem(
                context,
                "assets/icons/Calendar.svg",
                "Schedule",
                SCHEDULE_PAGE_INDEX,
                PRIMARY_BLUE,
                SECONDARY_RED,
              ),
              BottomNavBarItem(
                context,
                "assets/icons/Person.svg",
                "Settings",
                SETTINGS_PAGE_INDEX,
                PRIMARY_BLUE,
                SECONDARY_RED,
              ),
            ],
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: (value) {
              context.read<BottomNavCubit>().changeSelectedPage(value);
            },
            children: PAGES_LIST,
          ),
        );
      },
    );
  }
}
