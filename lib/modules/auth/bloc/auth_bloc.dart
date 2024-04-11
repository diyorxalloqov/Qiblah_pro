import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qiblah_pro/modules/auth/model/auth_model.dart';
import 'package:qiblah_pro/modules/auth/service/auth_service.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:uuid/uuid.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<RegisterEvent>(_register);
    on<RegisterTemporaryEvent>(_temporaryRegister);
    on<LoginEvent>(_login);
  }

  final AuthService _authService = AuthService();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<FutureOr<void>> _register(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: ActionStatus.isLoading));
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;

    Uuid uuid = const Uuid();
    String id = uuid.v4();
    debugPrint('Generated UUID: $id');

    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    }
    Either<String, AuthModel> res = await _authService.register(UserData(
        userLatitude: StorageRepository.getDouble(Keys.latitude).toString(),
        userLongitude: StorageRepository.getDouble(Keys.longitude).toString(),
        notification: StorageRepository.getBool(Keys.notification),
        notificationId: '0', //left
        userName: StorageRepository.getString(Keys.name),
        userGender: StorageRepository.getBool(Keys.isMan) ? 'Erkak' : 'Ayol',
        userExtraAuthId: '',
        userSigninMethod: 'AuthWithPhone',
        userAppLang: StorageRepository.getString(Keys.lang),
        userCountryCode: event.countryCode,
        userPhoneNumber: event.phoneNumber,
        userEmail: event.userEmail,
        userPassword: event.password,
        userRegion: StorageRepository.getString(Keys.country),
        userToken: id,
        userOs: Platform.isAndroid ? 'Android' : 'Ios',
        userAppVersion: packageInfo.version.replaceAll('.0', ''),
        userOsVersion: Platform.isAndroid
            ? androidInfo?.version.release
            : iosInfo?.systemVersion,
        userPhoneModel:
            Platform.isAndroid ? androidInfo?.model : iosInfo?.model,
        locationStatus: StorageRepository.getString(Keys.locationStatus) == '1'
            ? 1
            : StorageRepository.getString(Keys.locationStatus) == '2'
                ? 2
                : 3,
        userPhoneLang: Platform.localeName));
    res.fold(
        (l) => emit(state.copyWith(status: ActionStatus.isError, error: l)),
        (r) async {
      emit(state.copyWith(status: ActionStatus.isSuccess, authModel: r));
      await StorageRepository.putString(Keys.token, r.token ?? '');
      await StorageRepository.putString(Keys.userId, r.data?.userId ?? '');
    });
  }

  Future<FutureOr<void>> _temporaryRegister(
      RegisterTemporaryEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status1: ActionStatus.isLoading));

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;

    Uuid uuid = const Uuid();
    String id = uuid.v4();
    debugPrint('Generated UUID: $id');

    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    }
    Either<String, AuthModel> res = await _authService.registerTemporary(
        UserData(
            userLatitude: StorageRepository.getDouble(Keys.latitude).toString(),
            userLongitude:
                StorageRepository.getDouble(Keys.longitude).toString(),
            notification: StorageRepository.getBool(Keys.notification),
            notificationId: '0', //left
            userName: StorageRepository.getString(Keys.name),
            userGender:
                StorageRepository.getBool(Keys.isMan) ? 'Erkak' : 'Ayol',
            userAppLang: StorageRepository.getString(Keys.lang),
            userCountryCode: event.countryCode,
            userRegion: StorageRepository.getString(Keys.country),
            userToken: id,
            userOs: Platform.isAndroid ? 'Android' : 'Ios',
            userAppVersion: packageInfo.version.replaceAll('.0', ''),
            userOsVersion: Platform.isAndroid
                ? androidInfo?.version.release
                : iosInfo?.systemVersion,
            userPhoneModel:
                Platform.isAndroid ? androidInfo?.model : iosInfo?.model,
            userPhoneLang: Platform.localeName,
            locationStatus:
                StorageRepository.getString(Keys.locationStatus) == '1'
                    ? 1
                    : StorageRepository.getString(Keys.locationStatus) == '2'
                        ? 2
                        : 3));
    res.fold(
        (l) => emit(state.copyWith(status1: ActionStatus.isError, error: l)),
        (r) async {
      emit(state.copyWith(status1: ActionStatus.isSuccess, authModel: r));
      await StorageRepository.putString(Keys.token, r.token ?? '');
      await StorageRepository.putBool(Keys.isTemporaryUser, true);
    });
  }

  Future<FutureOr<void>> _login(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status2: ActionStatus.isLoading));

    Uuid uuid = const Uuid();
    String id = uuid.v4();
    debugPrint('Generated UUID: $id');

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Either<String, AuthModel> res = await _authService.login(
        UserData(
          userPhoneNumber: event.phoneNumber,
          userPassword: event.password,
          userAppVersion: packageInfo.version.replaceAll('.0', ''),
        ),
        StorageRepository.getString(Keys.token).isEmpty
            ? id
            : StorageRepository.getString(Keys.token));
    res.fold(
        (l) =>
            emit(state.copyWith(loginerror: l, status2: ActionStatus.isError)),
        (r) async {
      emit(state.copyWith(status2: ActionStatus.isSuccess));
      await StorageRepository.putString(Keys.userId, r.data?.userId ?? '');
      await StorageRepository.putString(Keys.token, r.token ?? '');
      await StorageRepository.putString(Keys.password, event.password);
      await StorageRepository.putString(Keys.phone, event.phoneNumber);
    });
  }
}
