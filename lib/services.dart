import 'package:onesignal_flutter/onesignal_flutter.dart';

class AppServices {
  void setOneSignal() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("cc87fe1f-6a65-4807-9342-049f1ec59a1a");
    OneSignal.Notifications.requestPermission(true).then((value) {
      print("Signal value: $value");
    });

    //    OneSignal.Notifications.addClickListener((event) {
    //     print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
    //     event.notification
    //   });

    //   OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    //     print(
    //         'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

    //     /// Display Notification, preventDefault to not display
    //     event.preventDefault();

    //     /// Do async work

    //     /// notification.display() to display after preventing default
    //     event.notification.display();

    //     setState(() {
    //       _debugLabelString =
    //           "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    //     });
    //   });
  }
}
