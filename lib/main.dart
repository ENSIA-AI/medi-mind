import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/presentation/bloc/bottom_nav_bloc.dart';
import 'package:medi_mind/presentation/views/add_medication_form.dart';
import 'package:medi_mind/presentation/views/main_app_screen.dart';
import 'package:medi_mind/presentation/views/Medication%20Details%20Pages/medication_details.dart';
import 'package:medi_mind/presentation/views/on_boarding_pages.dart';
import 'package:medi_mind/presentation/views/splash_screen.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV1.dart';
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
      routes: {
        '/': (context) => MedicationDetails(),
        '/onboarding': (context) => OnBoardingPages(),
        '/main': (context) => BlocProvider(
              create: (context) => BottomNavCubit(),
              child: MainAppScreen(), 
            ),
        '/addmed' : (context) => AddMedicationPage(),
      },
      initialRoute: '/editmed',
    );
  }
}
