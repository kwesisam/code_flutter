import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationA extends StatefulWidget {
  const NotificationA({super.key});

  @override
  State<NotificationA> createState() => _NotificationAState();
}

class _NotificationAState extends State<NotificationA> {
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  void triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'It is time for your medication!',
        body: 'Simple body',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: triggerNotification, child: const Text('Notification')),
      ),
    );
  }
}
