import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';

class OnBoardingPageInfoWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnBoardingPageInfoWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 250,
          child: Image.asset(imagePath),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: PRIMARY_BLUE,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 5),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: PRIMARY_BLUE,
                  fontWeight: FontWeight.w500,
                  fontSize: 16, // slightly increased the font size for better readability
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
