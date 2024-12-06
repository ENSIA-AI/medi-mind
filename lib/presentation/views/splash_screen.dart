import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _iconOpacity = 0;
  double _textOpacity = 0;
  double _iconPosition = 50; // Initial offset for the icon
  double _textPosition = 50; // Initial offset for the text

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Start the animation
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    // Animate the icon
    await Future.delayed(const Duration(milliseconds: 500)); // Optional delay
    setState(() {
      _iconOpacity = 1;
      _iconPosition = 0; // Move icon to its final position
    });

    // Animate the text after the icon animation
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _textOpacity = 1;
      _textPosition = 0; // Move text to its final position
    });

    // Navigate to the next screen after a short delay
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      Navigator.pushReplacementNamed(
          context, '/onboarding');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _iconOpacity,
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                transform: Matrix4.translationValues(0, _iconPosition, 0),
                child: SvgPicture.asset(
                  "assets/icons/app_logo.svg",
                  height: 60,
                  width: 60,
                  color: PRIMARY_BLUE,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _textOpacity,
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                transform: Matrix4.translationValues(0, _textPosition, 0),
                child: Text(
                  'MediMind',
                  style: LOGO_NAME_TEXT_STYLE,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
