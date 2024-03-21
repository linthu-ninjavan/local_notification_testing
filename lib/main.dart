import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notification_testing/notification_controller.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Basic Notifications Channel')
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group', channelGroupName: 'Basic Group')
  ]);
  bool isAllowToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onNotificationReceivedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  AwesomeNotifications().createNotification(
                content: NotificationContent(
                  
                    id: 1,
                    channelKey: 'basic_channel',
                    title: 'Hello Word!',
                    body: 'Yay hello body'));
                },
                child: Text('CLICK HERE'),
              )
            ],
          ),),
          floatingActionButton: FloatingActionButton(onPressed: () {
             AwesomeNotifications().createNotification(
                content: NotificationContent(
                  
                    id: 1,
                    channelKey: 'basic_channel',
                    title: 'Hello Word!',
                    body: 'Yay hello body'));
            
          })),
    );
  }
}
