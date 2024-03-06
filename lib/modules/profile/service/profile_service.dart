import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/profile/model/profile_model.dart';

class ProfileService {
  final Dio client = serviceLocator<DioSettings>().dio;

  Future<Either<String, ProfileModel>> putImage(String imagePath) async {
    try {
      FormData formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(imagePath,
            filename: imagePath.split('/').last),
      });
      Response response = await client.put(
          "${AppUrls.putImage}/${StorageRepository.getString(Keys.userId)}",
          data: formData,
          options: Options(
              headers: {'token': StorageRepository.getString(Keys.token)}));
      print('Response status: ${response.statusCode}');
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print(response.data);
        return right(ProfileModel.fromJson(response.data)); // not using
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      print('Error during image upload: $e');
      return left(e.message.toString());
    }
  }

  Future changeContact(UserData userdata) async {
    await profileRequests({
      "user_id": StorageRepository.getString(Keys.userId),
      "user_email": userdata.userEmail,
      "user_phone_number": userdata.userPhoneNumber,
      "user_password": userdata.userPassword
    }, AppUrls.changeContact);
  }

  Future changeName(UserData userdata) async {
    await profileRequests({
      "user_id": StorageRepository.getString(Keys.userId),
      "user_phone_number": userdata.userPhoneNumber,
      "user_name": userdata.userName,
      "user_gender": userdata.userGender,
    }, AppUrls.changeName);
  }

  // Future changeLocation(UserData userdata) async {
  //   await profileRequests({
  //     "user_id": StorageRepository.getString(Keys.userId),
  //     "user_country_code": userdata.userCountryCode,
  //     "user_region": userdata.userRegion,
  //     "user_location": "${userdata.userLatitude} ${userdata.userLongitude}",
  //     "location_status": StorageRepository.getInt(Keys.locationStatus)
  //   }, AppUrls.changeLocation);
  // }

  // Future<void> changePremium(bool userPremium) async {
  //   final Map<String, dynamic> requestData = {
  //     "user_id": StorageRepository.getString(Keys.userId),
  //     "user_premium": userPremium,
  //   };
  //   if (userPremium) {
  //     requestData["expires_at"] = DateTime.now();
  //   }
  //   await profileRequests(requestData, AppUrls.changePremium);
  // }

  // Future changeAppLang() async {
  //   await profileRequests({
  //     "user_id": StorageRepository.getString(Keys.userId),
  //     "lang": StorageRepository.getString(Keys.lang)
  //   }, AppUrls.changeLang);
  // }

  Future<Either<String, ProfileModel>> profileRequests(
      Object? data, String url) async {
    try {
      Response response = await client.put(url,
          data: data,
          options: Options(
              headers: {'token': StorageRepository.getString(Keys.token)}));
      print('Response status: ${response.statusCode}');
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print(response.data);
        return right(ProfileModel.fromJson(response.data));
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      print('Error: $e');
      return left(e.message.toString());
    }
  }

  Future<Either<String, ProfileModel>> deleteUser() async {
    try {
      Response response = await client.delete(AppUrls.deleteAccaunt,
          data: {"user_id": StorageRepository.getString(Keys.userId)},
          options: Options(
              headers: {'token': StorageRepository.getString(Keys.token)}));
      print('Response status: ${response.statusCode}');
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print(response.data);
        return right(ProfileModel.fromJson(response.data));
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      print('Error: $e');
      return left(e.message.toString());
    }
  }
}
