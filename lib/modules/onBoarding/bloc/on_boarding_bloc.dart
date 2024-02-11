import 'dart:async';

// import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;
import 'package:qiblah_pro/core/db/db_service.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(const OnBoardingState()) {
    on<ChangeLanguageEvent>(_changeLanguage);
    on<NotificationPermissionEvent>(_permissionNotification);
    on<UserDataEvent>(_userdata);
  }

  late PermissionStatus _notPermission;
  final DBService _dbService = DBService();

  var lang = const FlutterSecureStorage().read(key: Keys.lang);

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

  FutureOr<void> _userdata(UserDataEvent event, Emitter<OnBoardingState> emit) {
    try {
      _dbService
          .insertUserdata(UserModel(isMan: event.isMan, name: event.name));
      print('user data is saving');
    } on DatabaseException catch (e) {
      print(e.result.toString());
    }
  }
}
