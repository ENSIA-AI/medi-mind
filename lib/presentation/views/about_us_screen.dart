import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  void _showDummyLinkToast() {
    Fluttertoast.showToast(
      msg: "Dummy Link",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: PRIMARY_BLUE,
      textColor: Colors.white,
      fontSize: 16.0,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarV2(pageTitle: "About Us"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            SvgPicture.asset(
              "assets/icons/app_logo.svg",
              height: 80,
              width: 80,
              color: PRIMARY_BLUE,
            ),
            const SizedBox(height: 20),

            // App Name
            Text(
              'MediMind',
              style: LOGO_NAME_TEXT_STYLE,
            ),
            const SizedBox(height: 10),

            // Slogan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Simplifying your medication routine, one reminder at a time',
                textAlign: TextAlign.center,
                style: BLUE_SUBHEADING_TEXT_STYLE,
              ),
            ),

            const SizedBox(height: 40),

            // Version
            Text(
              'Version 1.0',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 40),

            // Social Media Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(
                  icon: Icons.facebook,
                  onTap: _showDummyLinkToast,
                ),
                const SizedBox(width: 20),
                _buildSocialButton(
                  icon: Icons.email,
                  onTap: _showDummyLinkToast,
                ),
                const SizedBox(width: 20),
                _buildSocialButton(
                  icon: Icons.camera_alt,
                  onTap: _showDummyLinkToast,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: PRIMARY_BLUE,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
