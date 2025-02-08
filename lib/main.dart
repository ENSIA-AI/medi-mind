import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medi_mind/presentation/bloc/bottom_nav_bloc.dart';
import 'package:medi_mind/presentation/views/add_medication_form.dart';
import 'package:medi_mind/presentation/views/main_app_screen.dart';
import 'package:medi_mind/presentation/views/on_boarding_pages.dart';
import 'package:medi_mind/presentation/views/report_screen.dart';
import 'package:medi_mind/presentation/views/splash_screen.dart';
import 'package:medi_mind/themes/themes.dart';
import 'package:permission_handler/permission_handler.dart';

// Create a global instance of FlutterLocalNotificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // Ensure Flutter binding is initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Request notification permissions
  try {
    var notificationStatus = await Permission.notification.request();

    if (notificationStatus.isGranted) {
      print('Notification permissions granted');
    } else {
      print('Notification permissions denied');
      // Optionally, handle permission denial
    }
  } catch (e) {
    print('Error requesting notification permission: $e');
  }

  // Initialize local notifications
  try {
    await initializeNotifications();
    print('Notifications initialized successfully');
  } catch (e) {
    print('Failed to initialize notifications: $e');
  }

  // Run the app
  runApp(const MainApp());
}

// Comprehensive notification initialization function
Future<void> initializeNotifications() async {
  // Android-specific initialization settings
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS initialization settings (if you plan to support iOS later)
  // const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();

  // Combine platform-specific settings
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS, // Uncomment when adding iOS support
  );

  // Create a notification channel for Android (required for Android 8.0+)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'medication_channel', // id
    'Medication Reminders', // title
    description: 'Channel for medication notifications',
    importance: Importance.max,
  );

  // Create the channel on the device
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  await androidImplementation?.createNotificationChannel(channel);

  // Initialize the plugin with settings and response handler
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap or action
      switch (response.actionId) {
        case 'done_action':
          print('Medication marked as taken');
          break;
        case 'skip_action':
          print('Medication skipped');
          break;
        default:
          print('Notification received: ${response.payload}');
      }
    },
  );
}

// Function to show medication reminder notification
Future<void> showMedicationNotification(String medicationName) async {
  // Detailed Android notification configuration
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'medication_channel', // must match the channel created in initialization
    'Medication Reminders',
    channelDescription: 'Channel for medication notifications',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
    // Add custom actions
    actions: [
      AndroidNotificationAction('done_action', 'Mark as Taken'),
      AndroidNotificationAction('skip_action', 'Skip'),
    ],
  );

  // Combine platform-specific notification details
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  // Show the actual notification
  await flutterLocalNotificationsPlugin.show(
    0, // Unique notification ID
    'Medication Reminder', // Title
    'Time to take $medicationName', // Body
    platformChannelSpecifics,
    payload: 'medication_reminder',
  );
}

// Main application widget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => BottomNavCubit())],
      child: MaterialApp(
        theme: materialTheme,
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnBoardingPages(),
          '/main': (context) => const MainAppScreen(),
          '/addmed': (context) => const AddMedicationPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
