import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/consts/consts.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/providers/addMedication/medication_provider.dart';
import 'package:medi_mind/presentation/bloc/bottom_nav_bloc.dart';
import 'package:medi_mind/presentation/views/main_app_screen.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/SelectTimes.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/day_selector.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/intake_complex_input.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_image_picker.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_select_form_field.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_text_form_field.dart';
import 'package:medi_mind/presentation/views/widgets/common/action_button.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/themes/themes.dart';
import 'package:provider/provider.dart';

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
