import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qiblah_pro/core/constants/app/constants.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';

class ScheduledNotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Check if app can schedule notification on Android 13+ (S+). Always return true on Android 12 and below.
  /// faqat schedule ni qabul qiladigan permission uchun ishlatildi Flutter_Local_Notification
  Future<bool> canScheduleNotification() async {
    final androidNotif =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    // underlying implementation: https://github.com/MaikuB/flutter_local_notifications/blob/ca71c96ba2a245175b44471e2e41e4958d480876/flutter_local_notifications/android/src/main/java/com/dexterous/flutterlocalnotifications/FlutterLocalNotificationsPlugin.java#L2119
    final res = await androidNotif?.canScheduleExactNotifications();
    return res ?? false;
  }


  /// Schedule notification for each prayer time.
  void schedulePrayNotification(List<DailyPrayerTimes> times) async {
    NotificationService().init();
    if (!await canScheduleNotification()) {
      print(
          'Notifications are not scheduled. Schedule notification permission is not granted huhu');
      return;
    }
    await flutterLocalNotificationsPlugin.cancelAll(); //reset all
    final currentDateTime = DateTime.now();

    // final NotificationType notifType = NotificationType
    //     .values[StorageRepository.getInt(Keys.kNotificationType)];

    await _defaultScheduler(times, currentDateTime);

    // agar ovozga azon qoshilsa

    // switch (notifType) {
    //   case NotificationType.noazan:
    //     showToastMessage('Notification: Default sound');
    //     _defaultScheduler(times, currentDateTime);
    //     break;
    //   case NotificationType.azan:
    //     showToastMessage('Notification: Azan');
    //     _azanScheduler(times, currentDateTime);
    //     break;
    //   case NotificationType.shortAzan:
    //     _azanScheduler(times, currentDateTime, short: true);
    // }

    await NotificationService().scheduleAlertNotification(
        id: 2190,
        title: 'Monthly refresh reminder',
        body:
            'To continue receive prayer notification, open app at least once every month',
        // if month (12 + 1) = 13, it will auto-increment to next year
        //2021-01-01 00:05:00.000+0800
        scheduledTime:
            DateTime(currentDateTime.year, currentDateTime.month + 1, 1, 0, 5));

    //This timestamp is later used to determine wether notification should be updated or not
    // user oxirgi notification ni ovozini tanlaganda saqlash vaqt bilan
    // GetStorage()
    //     .write(kStoredLastUpdateNotif, DateTime.now().millisecondsSinceEpoch);
  }

  /// Classic Notification Scheduler, default notification sound
  static Future<void> _defaultScheduler(
      List<DailyPrayerTimes> times, DateTime currentDateTime) async {
    List<String> titles = AppConstants.titles;
    List<String> bodys = AppConstants.bodys;

    for (var dayTime in times) {
      if (dayTime.bomdod.time.isAfter(currentDateTime)) {
        //to make sure the time is in future
        await NotificationService().scheduleSinglePrayerNotification(
           
          name: 'Fajr',
          // Note: previosly, there was a bug with this id.
          // Read more: https://github.com/mptwaktusolat/app_waktu_solat_malaysia/issues/201
          id: int.parse(dayTime.bomdod.time.millisecondsSinceEpoch
              .toString()
              .replaceAll(RegExp(r'0+$'), "")),
          title: titles[0],
          scheduledTime: dayTime.bomdod.time,
          body: bodys[0],
        );
      }
      if (dayTime.quyosh.time.isAfter(currentDateTime)) {
        await NotificationService().scheduleSinglePrayerNotification(
          name: 'Zuho',
          id: int.parse(dayTime.quyosh.time.millisecondsSinceEpoch
              .toString()
              .replaceAll(RegExp(r'0+$'), "")),
          title: titles[1],
          body: titles[1],
          summary: '',
          scheduledTime: dayTime.quyosh.time,
        );
      }
      if (dayTime.peshin.time.isAfter(currentDateTime)) {
        await NotificationService().scheduleSinglePrayerNotification(
          name: 'Zuhr',
          id: int.parse(dayTime.peshin.time.millisecondsSinceEpoch
              .toString()
              .replaceAll(RegExp(r'0+$'), "")),
          title: titles[2],
          body: bodys[2],
          summary: dayTime.peshin.time.weekday == DateTime.friday
              ? 'Salam Jumaat'
              : null,
          scheduledTime: dayTime.peshin.time,
        );
      }
      if (dayTime.asr.time.isAfter(currentDateTime)) {
        await NotificationService().scheduleSinglePrayerNotification(
          name: 'Asr',
          id: int.parse(dayTime.asr.time.millisecondsSinceEpoch
              .toString()
              .replaceAll(RegExp(r'0+$'), "")),
          title: titles[3],
          body: bodys[3],
          scheduledTime: dayTime.asr.time,
        );
      }
      if (dayTime.shom.time.isAfter(currentDateTime)) {
        await NotificationService().scheduleSinglePrayerNotification(
          name: 'Maghrib',
          id: int.parse(dayTime.shom.time.millisecondsSinceEpoch
              .toString()
              .replaceAll(RegExp(r'0+$'), "")),
          title: titles[4],
          body: bodys[4],
          scheduledTime: dayTime.shom.time,
        );
      }
      if (dayTime.xufton.time.isAfter(currentDateTime)) {
        await NotificationService().scheduleSinglePrayerNotification(
          name: 'Isha',
          id: int.parse(dayTime.xufton.time.millisecondsSinceEpoch
              .toString()
              .replaceAll(RegExp(r'0+$'), "")),
          title: titles[5],
          body: bodys[5],
          scheduledTime: dayTime.xufton.time,
        );
      }
    }
  }

  // /// Notification but with azan
  // static void _azanScheduler(List<DailyScscheduledTimes> times,
  //     DateTime currentDateTime, List<String> titles, List<String> bodys,
  //     {bool short = false}) async {
  //   for (var dayTime in times) {
  //     if (dayTime.bomdod.time.isAfter(currentDateTime)) {
  //       //to make sure the time is in future
  //       await NotificationService().scheduleSingleAzanNotification(
  //         name: short ? 'Fajr short' : 'Fajr',
  //         id: int.parse(dayTime.bomdod.time.millisecondsSinceEpoch
  //             .toString()
  //             .replaceAll(RegExp(r'0+$'), "")),
  //         title: titles[0],
  //         scheduledTime: TZDateTime.from(dayTime.bomdod.time, local),
  //         body: bodys[0],
  //         customSound: short ? 'azan_short_lamy2005' : 'azan_hejaz2013_fajr',
  //       );
  //     }
  //     if (dayTime.quyosh.time.isAfter(currentDateTime)) {
  //       await NotificationService().scheduleSinglePrayerNotification(
  //         name: 'Syuruk',
  //         id: int.parse(dayTime.quyosh.time.millisecondsSinceEpoch
  //             .toString()
  //             .replaceAll(RegExp(r'0+$'), "")),
  //         title: titles[1],
  //         body: bodys[1],
  //         summary: appLocalizations.notifEndSubh,
  //         scheduledTime: TZDateTime.from(dayTime.quyosh.time, local),
  //       );
  //     }
  //     if (dayTime.peshin.time.isAfter(currentDateTime)) {
  //       await NotificationService().scheduleSingleAzanNotification(
  //         name: short ? 'Zuhr short' : 'Zuhr',
  //         id: int.parse(dayTime.peshin.time.millisecondsSinceEpoch
  //             .toString()
  //             .replaceAll(RegExp(r'0+$'), "")),
  //         title: titles[2],
  //         body: bodys[2],
  //         summary: dayTime.peshin.time.weekday == DateTime.friday
  //             ? 'Salam Jumaat'
  //             : null,
  //         scheduledTime: TZDateTime.from(dayTime.peshin.time, local),
  //         customSound: short ? 'azan_short_lamy2005' : 'azan_kurdhi2010',
  //       );
  //     }
  //     if (dayTime.asr.time.isAfter(currentDateTime)) {
  //       await NotificationService().scheduleSingleAzanNotification(
  //         name: short ? 'Asr short' : 'Asr',
  //         id: int.parse(dayTime.asr.time.millisecondsSinceEpoch
  //             .toString()
  //             .replaceAll(RegExp(r'0+$'), "")),
  //         title: titles[3],
  //         body: bodys[3],
  //         scheduledTime: TZDateTime.from(dayTime.asr.time, local),
  //         customSound: short ? 'azan_short_lamy2005' : 'azan_kurdhi2010',
  //       );
  //     }
  //     if (dayTime.shom.time.isAfter(currentDateTime)) {
  //       await NotificationService().scheduleSingleAzanNotification(
  //         name: short ? 'Maghrib short' : 'Maghrib',
  //         id: int.parse(dayTime.shom.time.millisecondsSinceEpoch
  //             .toString()
  //             .replaceAll(RegExp(r'0+$'), "")),
  //         title: titles[4],
  //         body: bodys[4],
  //         scheduledTime: TZDateTime.from(dayTime.shom.time, local),
  //         customSound: short ? 'azan_short_lamy2005' : 'azan_kurdhi2010',
  //       );
  //     }
  //     if (dayTime.xufton.time.isAfter(currentDateTime)) {
  //       await NotificationService().scheduleSingleAzanNotification(
  //         name: short ? 'Isya\' short' : 'Isya\'',
  //         id: int.parse(dayTime.xufton.time.millisecondsSinceEpoch
  //             .toString()
  //             .replaceAll(RegExp(r'0+$'), "")),
  //         title: titles[5],
  //         body: bodys[5],
  //         scheduledTime: TZDateTime.from(dayTime.xufton.time, local),
  //         customSound: short ? 'azan_short_lamy2005' : 'azan_kurdhi2010',
  //       );
  //     }
  //   }
  // }
}
