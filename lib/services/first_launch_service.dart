import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchService {
  static const String _firstLaunchKey = 'is_first_launch';

  static Future<bool> isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLaunch = prefs.getBool(_firstLaunchKey);
    
    if (isFirstLaunch == null) {
      await prefs.setBool(_firstLaunchKey, false);
      return true;
    }
    
    return false;
  }
} 