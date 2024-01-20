import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(const OnBoardingState()) {
    on<LocationPermissionEvent>(_permissionLocation);
    on<ChangeLanguageEvent>(_changeLanguage);
    on<NotificationPermissionEvent>(_permissionNotification);
  }

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  var lang = const FlutterSecureStorage().read(key: Keys.lang);

  FutureOr<void> _permissionLocation(
      LocationPermissionEvent event, Emitter<OnBoardingState> emit) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        // Initialize _locationData before using it
        _locationData = await location.getLocation();
        emit(state.copyWith(
          isGarantedLocation: true,
          latitude: _locationData.latitude,
          longitude: _locationData.longitude,
        ));
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      // Initialize _locationData before using it
      _locationData = await location.getLocation();
      emit(state.copyWith(
        isGarantedLocation: true,
        latitude: _locationData.latitude,
        longitude: _locationData.longitude,
      ));
    }
  }

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
    // Check the current status of notification permission
    var status = await Permission.notification.status;

    // If notification permission is denied, request it
    if (status.isDenied) {
      status = await Permission.notification.request();
    }

    // If notification permission is granted, update the state
    if (status.isGranted) {
      print('Notification permission granted');
      emit(state.copyWith(isGarantedNotification: true));
    }
  }
}
