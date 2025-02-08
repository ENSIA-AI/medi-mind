import 'package:flutter/material.dart';
import 'package:medi_mind/data/dbhelper/notificationDbHelper.dart';
import 'package:medi_mind/data/model/notification_obj.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/Notifications/notif_widgets.dart';
import 'dart:async';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Timer _timer;
  late Future<List<NotificationObj>> _notifFuture;
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _notifFuture = fetchNotifObjs(); // Initial fetch
    startAutoRefresh();
    startNotificationUpdater();
  }

  Future<bool> onWillPop() async {
  await saveNotificationsToDB();
  return true;
}

  Future<List<NotificationObj>> fetchNotifObjs() async {
    return await fetchNotificationsToDisplay();
  }

  void startAutoRefresh() {
    _timer = Timer.periodic(const Duration(minutes: 3), (timer) {
      _refreshNotificationList(); // Refresh only the list
    });
  }

  Future<void> _refreshNotificationList() async {
    setState(() {
      _notifFuture = fetchNotifObjs(); // Update only the notification list
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarV2(pageTitle: "Notification"),
      body: Column(
        children: [
          const SizedBox(height: 8), // Adds spacing
          const labelWidget(sectionTitle: "Today"), // Static title
          Expanded(
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: _refreshNotificationList,
              child: FutureBuilder<List<NotificationObj>>(
                future: _notifFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show loading indicator
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text("No notifications available"));
                  } else {
                    List<NotificationObj> notifObjs = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: notifObjs.length,
                      itemBuilder: (context, index) {
                        return NotificationItem(notification: notifObjs[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
