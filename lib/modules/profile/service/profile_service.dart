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

  Future<Either<String, ProfileModel>> changeContact(UserData userdata) async {
    try {
      Response response = await client.put(AppUrls.changeContact,
          data: {
            "user_id": StorageRepository.getString(Keys.userId),
            "user_email": userdata.userEmail,
            "user_phone_number": userdata.userPhoneNumber,
            "user_password": userdata.userPassword
          },
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

  Future<Either<String, ProfileModel>> changeName(UserData userdata) async {
    try {
      Response response = await client.put(AppUrls.changeName,
          data: {
            "user_id": StorageRepository.getString(Keys.userId),
            "user_phone_number": userdata.userPhoneNumber,
            "user_name": userdata.userName,
            "user_gender": userdata.userGender,
          },
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

  Future<Either<String, ProfileModel>> changeLocation(UserData userdata) async {
    try {
      Response response = await client.put(AppUrls.changeLocation,
          data: {
            "user_id": StorageRepository.getString(Keys.userId),
            "user_country_code": userdata.userCountryCode,
            "user_region": StorageRepository.getString(Keys.country),
            "user_location":
                "${StorageRepository.getString(Keys.latitude)} ${StorageRepository.getString(Keys.longitude)}",
            "location_status": StorageRepository.getInt(Keys.locationStatus)
          },
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

  Future<Either<String, ProfileModel>> changePremium(bool userPremium) async {
    final Map<String, dynamic> requestData = {
      "user_id": StorageRepository.getString(Keys.userId),
      "user_premium": userPremium,
    };
    if (userPremium) {
      requestData["expires_at"] = DateTime.now(); // not correct
    }
    try {
      Response response = await client.put(AppUrls.changeLocation,
          data: requestData,
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

  Future<Either<String, ProfileModel>> changeAppLang(String lang) async {
    try {
      Response response = await client.put(AppUrls.changeLang,
          data: {
            "user_id": StorageRepository.getString(Keys.userId),
            "lang": lang
          },
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
