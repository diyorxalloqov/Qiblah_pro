import 'dart:developer';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  DarwinInitializationSettings initializationSettingsDarwin =
      const DarwinInitializationSettings();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Future<bool> init() async {
  //   final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  //   tz.initializeTimeZones();
  //   tz.setLocalLocation(tz.getLocation(timeZoneName));
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestNotificationsPermission();
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );

  //   var requestAndorid = await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestNotificationsPermission();
  //   var requestIos = await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(alert: true, badge: true, sound: true);

  //   InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsDarwin,
  //   );
  //   await flutterLocalNotificationsPlugin
  //       .initialize(initializationSettings)
  //       .then((value) {
  //     log("Notification status: $value ");
  //   });

  //   return Platform.isAndroid ? requestAndorid ?? false : requestIos ?? false;
  // }
  Future<bool> init() async {
    try {
      final String timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation(timeZoneName));

      // Request permissions
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      var requestAndorid = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      var requestIos = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      // Initialize notifications
      InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );
      await flutterLocalNotificationsPlugin
          .initialize(initializationSettings)
          .then((value) {
        log("Notification status: $value ");
      });

      return Platform.isAndroid ? requestAndorid ?? false : requestIos ?? false;
    } catch (e) {
      log('Error initializing notifications: $e');
      return false;
    }
  }

  Future<void> setNotification(
      {required DateTime date,
      required String title,
      required String body,
      required int id}) async {
    log("$date");
    print("$date coming date");
    print(tz.TZDateTime.from(date, tz.local));
    print('changing time');
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(date, tz.local),
        const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            channelDescription: 'your channel description',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print("Date $date scheduled notification");

      log('Notification scheduled!');
    } catch (error) {
      log('Error: $error');
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
