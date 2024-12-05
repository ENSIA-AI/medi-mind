import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/presentation/bloc/bottom_nav_bloc.dart';
import 'package:medi_mind/presentation/views/main_app_screen.dart';
import 'package:medi_mind/themes/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: materialTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Testiee"),
        ),
          resizeToAvoidBottomInset: false,
          body: BlocProvider(
            create: (context) => BottomNavCubit(),
            child: MainAppScreen(),
          )),
    );
  }
}
