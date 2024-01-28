import 'dart:async';

// import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(const OnBoardingState()) {
    on<ChangeLanguageEvent>(_changeLanguage);
    on<NotificationPermissionEvent>(_permissionNotification);

    on<LocationPermissionEvent>(_locationSettings);
  }

  // Location location = Location();
  // late bool _serviceEnabled;
  // late PermissionStatus _permissionGranted;
  // late LocationData _locationData;
  late PermissionStatus _notPermission;

  var lang = const FlutterSecureStorage().read(key: Keys.lang);

  void _locationSettings(
      LocationPermissionEvent event, Emitter<OnBoardingState> emit) async {
    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }

    // _permissionGranted = await Permission.location.status;
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await Permission.notification.request();
    //   if (_permissionGranted == PermissionStatus.granted ||
    //       _permissionGranted == PermissionStatus.limited) {
    //     // Initialize _locationData before using it
    //     _locationData = await location.getLocation();
    //     emit(state.copyWith(
    //         isGarantedLocation: true,
    //         latitude: _locationData.latitude,
    //         longitude: _locationData.longitude));
    //   }
    // } else if (_permissionGranted == PermissionStatus.granted) {
    //   _locationData = await location.getLocation();
    //   emit(state.copyWith(
    //       isGarantedLocation: true,
    //       latitude: _locationData.latitude,
    //       longitude: _locationData.longitude));
    // }
  }

  ////////////

  FutureOr<void> _changeLanguage(
      ChangeLanguageEvent event, Emitter<OnBoardingState> emit) async {
    if (await lang != null || lang.toString().isNotEmpty) {
      print('isnot empty');
      emit(state.copyWith(language: lang.toString()));
    } else {
      print('isempty');
      await const FlutterSecureStorage()
          .write(key: Keys.lang, value: event.selectedLanguageCode);
      emit(state.copyWith(language: event.selectedLanguageCode));
    }
  }

  FutureOr<void> _permissionNotification(
      NotificationPermissionEvent event, Emitter<OnBoardingState> emit) async {
    _notPermission = await Permission.notification.status;
    print(_notPermission);

    if (_notPermission.isDenied || _notPermission.isPermanentlyDenied) {
      // Request permission only if it is denied or permanently denied
      await Permission.notification.request();
      _notPermission = await Permission.notification.status;
      print('${Permission.notification} status notification');
    }

    if (_notPermission.isGranted) {
      print('Notification permission granted');
      emit(state.copyWith(isGarantedNotification: true));
      print(state.isGarantedNotification);
    } else {
      print('Notification permission denied');
      emit(state.copyWith(isGarantedNotification: false));
    }
  }
}
