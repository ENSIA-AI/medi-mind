import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/notification_settings.dart';
import 'package:medi_mind/presentation/views/widgets/Settings/SettingTile.dart';
import 'package:medi_mind/presentation/views/widgets/Settings/switch_settings.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarV2(pageTitle: "Settings & Preferences" ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          SettingTile(
            title: "Notification Settings",
            iconPath: const Icon(Icons.notifications, color: PRIMARY_BLUE),
            destination: NotificationSettingsScreen(),
          ),
          SettingTile(
            title: "Account Settings",
            iconPath: const Icon(Icons.account_circle_outlined, color: PRIMARY_BLUE),
            destination: NotificationSettingsScreen(), // Replace with appropriate screen later
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.language, color: PRIMARY_BLUE),
              title: Text(
                'Language',
                style: BLUE_TEXT_STYLE,
              ),
              subtitle: const Text('English (US)' , style: TextStyle( fontFamily: 'LeagueSpartan'),),
               trailing: const Icon(Icons.arrow_forward_ios_rounded, color: PRIMARY_BLUE , size: 20,),
              onTap: () {
                print("Change language");
              },
            ),
          ),
          SwitchTile(title: 'Activate Dark Mode', boolValue: isDarkMode, onChanged: (bool value){
                    setState(() {
            isDarkMode = value;
            print("$value is dark mode");
                    });
                  },)]));
  }
}
