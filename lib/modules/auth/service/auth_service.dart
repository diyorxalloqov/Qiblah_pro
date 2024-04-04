import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/auth/model/auth_model.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class AuthService {
  final Dio client = serviceLocator<DioSettings>().dio;
  Future<Either<String, AuthModel>> register(UserData userData) async {
    Map<String, Object?> data = {
      "user_phone_number": userData.userPhoneNumber,
      "user_email": userData.userEmail,
      "user_password": userData.userPassword,
      "user_name": userData.userName,
      "user_gender": userData.userGender,
      "user_signin_method": userData.userSigninMethod,
      "user_extra_auth_id": userData.userExtraAuthId,
      "user_country_code": userData.userCountryCode,
      "user_region": userData.userRegion,
      "user_location": "${userData.userLatitude}, ${userData.userLongitude}",
      "user_app_lang": userData.userAppLang,
      "user_phone_model": userData.userPhoneModel,
      "user_phone_lang": userData.userPhoneLang,
      "user_os": userData.userOs,
      "user_os_version": userData.userOsVersion,
      "user_token": userData.userToken,
      "user_app_version": userData.userAppVersion,
      "notification_id": userData.notificationId,
      "notification": userData.notification,
      "location_status": userData.locationStatus,
    };
    print(data);
    try {
      print('response is trying to register');
      Response response = await client.post(AppUrls.register, data: data);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print(response.data);

        return right(AuthModel.fromJson(response.data));
      } else if (response.statusCode == 302) {
        return left(NetworkErrorResponse('bu_foydalanuvchi_mavjud'.tr()).error);
      } else {
        return left(
            NetworkErrorResponse(response.statusMessage.toString()).error);
      }
    } on DioException catch (e) {
      print('exeption $e');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }

  Future<Either<String, AuthModel>> registerTemporary(UserData userData) async {
    Map<String, Object?> data = {
      "user_name": userData.userName,
      "user_gender": userData.userGender,
      "user_country_code": userData.userCountryCode,
      "user_region": userData.userRegion,
      "user_location": "${userData.userLatitude}, ${userData.userLongitude}",
      "user_app_lang": userData.userAppLang,
      "user_phone_model": userData.userPhoneModel,
      "user_phone_lang": userData.userPhoneLang,
      "user_os": userData.userOs,
      "user_os_version": userData.userOsVersion,
      "user_token": userData.userToken,
      "user_app_version": userData.userAppVersion,
      "notification_id": userData.notificationId,
      "notification": userData.notification,
      "location_status": userData.locationStatus
    };
    print(data);
    try {
      print('response is trying to temporary');
      Response response =
          await client.post(AppUrls.temporaryRegister, data: data);
      print(response.statusCode);
      print(response.data);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print(response.data);

        return right(AuthModel.fromJson(response.data));
      } else {
        return left(
            NetworkErrorResponse(response.statusMessage.toString()).error);
      }
    } on DioException catch (e) {
      print('exeption $e');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }

  Future<Either<String, AuthModel>> login(
      // login tekshirish kerak
      UserData userData,
      String token) async {
    Map<String, Object?> data = {
      "user_phone_number": userData.userPhoneNumber,
      "user_password": userData.userPassword,
      "user_token": token,
      "user_app_version": userData.userAppVersion
    };

    print(data);
    try {
      print('response is trying to login');
      Response response = await client.post(AppUrls.login, data: data);
      print(response.statusCode);
      print(response.data);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print(response.data);

        return right(AuthModel.fromJson(response.data));
      } else {
        return left(
            NetworkErrorResponse(response.statusMessage.toString()).error);
      }
    } on DioException catch (e) {
      print('exeption $e');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }
}
