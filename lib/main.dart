import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

void main() {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'notify_me_channel_group',
            channelKey: 'know_something_channel',
            channelName: 'Know Something Channel Notifications',
            channelDescription:
                'Notification channel for the Know Something questionaire',
            defaultColor: const Color(0xFF0082c7),
            ledColor: Colors.white,
            icon: 'resource://drawable/check',
            importance: NotificationImportance.High,
            channelShowBadge: true),
        NotificationChannel(
            channelGroupKey: 'notify_me_channel_group',
            channelKey: 'error_channel',
            channelName: 'Error Channel Notifications',
            channelDescription: 'Notification channel for acknowledging Error',
            icon: 'resource://drawable/error',
            defaultColor: const Color(0xFFffa321),
            ledColor: Colors.white),
        NotificationChannel(
            channelGroupKey: 'notify_me_channel_group',
            channelKey: 'success_channel',
            icon: 'resource://drawable/info',
            channelName: 'Success Channel Notifications',
            channelDescription:
                'Notification channel for acknowledging Success',
            defaultColor: const Color(0xFF07ae76),
            ledColor: Colors.white),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'notify_me_channel_group',
            channelGroupName: 'Notify Me Channel Group')
      ],
      debug: true);
  runApp(const NotifyMeApp());
}

class NotifyMeApp extends StatefulWidget {
  const NotifyMeApp({Key? key}) : super(key: key);

  @override
  _NotifyMeAppState createState() => _NotifyMeAppState();
}

class _NotifyMeAppState extends State<NotifyMeApp> {
  var index = 0;
  var title = 'Did you know?';
  var body = 'Here is something that you might know.';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFF0082c7)
                            .withOpacity(index == 0 ? 1.0 : 0.6),
                        borderRadius: BorderRadius.circular(32)),
                    child: const Text(
                      "Questionaire",
                      style: TextStyle(color: Colors.white),
                    )),
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFFffa321)
                            .withOpacity(index == 1 ? 1.0 : 0.6),
                        borderRadius: BorderRadius.circular(32)),
                    child: const Text("Error")),
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFF07ae76)
                            .withOpacity(index == 2 ? 1.0 : 0.6),
                        borderRadius: BorderRadius.circular(32)),
                    child: const Text("Success")),
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            child: Container(
              width: 180,
              height: 64,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(32)),
              child: Center(
                child: Text(
                  "Notify Me!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            onTap: () {
              AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                if (!isAllowed) {
                  // This is just a basic example. For real apps, you must show some
                  // friendly dialog box before call the request method.
                  // This is very important to not harm the user experience
                  AwesomeNotifications().requestPermissionToSendNotifications();
                }
              });
              if (index == 0) {
                title = 'Did you know?';
                body = 'Here is something that you might know.';
              } else if (index == 1) {
                title = "Uh oh, something went wrong";
                body = "Sorry! There was a problem with your request";
              } else {
                title = "Yay! Everything worked!";
                body = "Congrats on the internet loading your request";
              }
              AwesomeNotifications().createNotification(
                  content: NotificationContent(
                      id: DateTime.now().millisecond,
                      channelKey: index == 0
                          ? 'know_something_channel'
                          : index == 1
                              ? 'error_channel'
                              : 'success_channel',
                      title: title,
                      body: body));
            },
          ),
        ],
      )),
    );
  }
}
