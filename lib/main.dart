import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_mind/presentation/bloc/bottom_nav_bloc.dart';
import 'package:medi_mind/presentation/views/main_app_screen.dart';
import 'package:medi_mind/presentation/views/widgets/action_button.dart';
import 'package:medi_mind/presentation/views/widgets/bottom_nav_item.dart';
import 'package:medi_mind/presentation/views/widgets/logo_name_widget.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/themes/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: MaterialApp(
        theme: materialTheme ,
        home: MainAppScreen(),
      ),
    );
  }
}
