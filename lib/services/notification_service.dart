import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NotificationService {
  NotificationService({Function onMessage, Function onBackground}) {
    var logger = Logger();
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      logger.d("_messaging onMessageOpenedApp: $message");
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        logger.d("_messaging getInitialMessage: $message");
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // navigatorKey.currentState.push(MaterialPageRoute(
      //     builder: (BuildContext context) => LaborersScreen(category: "hi")));
      logger.d("_messaging onMessage: $message");
      onMessage(message.notification.title);
      // RemoteNotification notification = message.notification;
      // Map<String, dynamic> data = message.data;
      // Fcm.showNotification(notification.body, notification.title);
      // String type = data['type'];
      // if (type == "view") {
      //   String notifPath = data['subject'];
      //   // notificationProvider.addPath(notifPath);
      //   logger.d('new notification added to notificationList: $notifPath');
      // }
    });

    Future<void> firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      onBackground(message.notification.title);
      logger.d("_messaging onBackgroundMessage: ${message.sentTime}");
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future sendNotification(
      String body, String title, String token) async {
    final serverToken =
        "AAAA2Wt3nbc:APA91bGAPVwJtvL6x42j5XWQTT3m-W11jnBGAJoNMirZJZqsEQOJj8FDKwLsTN5qa6PbcXvCnp6IZ8JuNSsNu2XjDddL5LBtyTdxt3GUGGDFmCls4h8Mk90p_4WqQqgYWIQe3jW1fi7K";

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body ?? '',
            'title': title ?? ''
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'screen': 'screen'
          },
          'to': token,
        },
      ),
    );
  }
}
