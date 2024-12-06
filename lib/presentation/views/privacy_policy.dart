import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/widgets/app_barV2.dart';
import 'package:medi_mind/themes/colors.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // app bar 
      appBar: AppBarV2(pageTitle: "Privacy Policy"),
      // body 
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Last Update: 14/11/2024",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 , color: SECONDARY_BURGUNDY),
                ),
                SizedBox(height: 16),
                Text(
                    "At Medi_Mind, we prioritize your privacy and are committed to protecting your personal information. This Privacy Policy explains how we handle, store, and use your data." ),
                SizedBox(height: 16),
                Text(
                    "Medi_Mind collects essential personal information, such as your name, email address, and medication schedules, to provide accurate reminders, syncing with caregivers, and personalized notifications. We only collect the data necessary to enhance your experience and deliver the app’s core functionality."),
                SizedBox(height: 16),
                Text(
                    "Your data is stored securely and encrypted to ensure its safety. Medi_Mind complies with all relevant privacy regulations and uses industry-standard security protocols to protect your information from unauthorized access. We continuously monitor and update our systems to maintain the highest security standards."),
                SizedBox(height: 16),
                Text(
                    "To improve your experience, Medi_Mind may use trusted third-party services (e.g., notification systems, QR code scanning). These services are carefully vetted to ensure data protection and privacy compliance. Medi_Mind does not sell or share your personal data with any third-party organization for commercial purposes."),
                SizedBox(height: 16),
                Text(
                    "You have the right to access, update, or delete your personal data at any time. If you have any concerns or questions about your privacy, please contact us at “Medi_Mind@gmail.com”."),
                SizedBox(height: 30),
                Text(
                  "Terms & Conditions",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24 , color: PRIMARY_BLUE),
                ),
                SizedBox(height: 16),
                Text(
                    "1- Medi_Mind is a medical reminder app designed to help users manage their medication schedules effectively. By using Medi_Mind, you agree to provide accurate information to ensure proper functionality, such as medication names, dosages, and schedules." , style: TextStyle(),),
                SizedBox(height: 16),
                Text(
                    "2- Users are responsible for ensuring that the information entered into Medi_Mind is correct and up to date. Medi_Mind is intended solely for personal use. Any unauthorized or commercial use of the app is strictly prohibited."),
                SizedBox(height: 16),
                Text(
                    "3- Medi_Mind serves as a tool for managing medication reminders but does not provide medical advice. Users should consult a healthcare professional for any medical concerns, changes to prescriptions, or treatment decisions. Medi_Mind is not liable for missed medications or incorrect entries made by the user."),
                SizedBox(height: 16),
                Text(
                    "4- Medi_Mind reserves the right to update these Terms & Conditions or modify features of the app at any time. Users will be notified of significant changes through in-app messages or email notifications. Continued use of the app after updates signifies your acceptance of the changes."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
