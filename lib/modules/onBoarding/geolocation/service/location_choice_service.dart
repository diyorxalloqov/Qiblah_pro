// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:geocoding/geocoding.dart';
// import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

// class LocationChooserService {
// Future<PositionInfo> getChosenLocation() async {
//   PositionInfo rawJSON = PositionInfo(
//       latitude: StorageRepository.getDouble(Keys.latitude),
//       longitude: StorageRepository.getDouble(Keys.longitude),
//       country: StorageRepository.getString(Keys.country),
//       region: StorageRepository.getString(Keys.region),
//       isPrecise: StorageRepository.getBool(Keys.isPrecise));

//   print(rawJSON.country);
//   print(rawJSON.region);
//   print(rawJSON.latitude);
//   print(rawJSON.isPrecise);
//   print(rawJSON.longitude);

//   return rawJSON;
// }

// Future<void> saveLocationChoice(PositionInfo? positionInfo) async {
//   if (positionInfo == null) {
//     // TODO instead emit error to the UI state
//     return;
//   }
//   PositionInfo? positionToStore = positionInfo;
//   if (positionInfo.country == null && positionInfo.region == null) {
//     positionToStore = await addAddressInfo(positionInfo);
//     if (positionToStore == null) {
//       // TODO instead emit error to the UI state
//       return;
//     }
//   }
//   print('$positionInfo position info service');

//   print("${positionToStore.country} position to store");
//   await StorageRepository.putString(Keys.country, positionToStore.country!);
//   await StorageRepository.putString(Keys.region, positionToStore.region!);
//   await StorageRepository.putBool(Keys.isPrecise, positionInfo.isPrecise);
//   await StorageRepository.putDouble(
//       Keys.longitude, positionToStore.longitude);
//   await StorageRepository.putDouble(Keys.latitude, positionToStore.latitude);
// }

//   Future<PositionInfo?> addAddressInfo(PositionInfo? positionInfo) async {
//     print(
//         'addAddressInfo lat: ${positionInfo?.latitude} long: ${positionInfo?.longitude}');
//     if (positionInfo == null) {
//       // TODO instead emit error to UI state;
//       return null;
//     }
//     // TODO add indexoutoufbound and null handling
//     var placemark = (await placemarkFromCoordinates(
//             positionInfo.latitude, positionInfo.longitude))
//         .first;
//     print(
//         "${placemark.country} city ${placemark.administrativeArea} area ${positionInfo.isPrecise} location data is ");
//     print(
//         "${positionInfo.country} country ${positionInfo.region} region ${positionInfo.latitude} location data new ");

//     return PositionInfo(
//       country: placemark.country,
//       region: placemark.administrativeArea,
//       latitude: positionInfo.latitude,
//       longitude: positionInfo.longitude,
//       isPrecise: positionInfo.isPrecise,
//     );
//   }
// }

import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/model/auto_complete_model.dart';

class LocationService {
  final Dio client = serviceLocator<DioSettings>().dio;
  final List<String> apiKeys = [
    "5651ef63d5444573b410f711ca85aaa0",
    "12fd37d29a1b47afa13998b079bac572",
    "aeb7b532d7344768b4a2be486835980b",
    "25c48c619bae49c28005cbbd22e6a6b2"
  ];

  Future<Either<String, AutoChoiceLocationModel>> autoChoiceLocation() async {
    final String randomKey = apiKeys[Random().nextInt(apiKeys.length)];
    print(randomKey);
    try {
      Response response = await client
          .get('https://api.geoapify.com/v1/ipinfo?&apiKey=$randomKey');
      print(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return right(AutoChoiceLocationModel.fromJson(response.data));
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      print('exeption');
      return left(e.message.toString());
    }
  }

  Future<Either<String, ManualChoserModel>> manuaChoiceLocation(
      String place) async {
    final String randomKey = apiKeys[Random().nextInt(apiKeys.length)];
    print(randomKey);
    try {
      Response response = await client.get(
          'https://api.geoapify.com/v1/geocode/autocomplete?text=$place&apiKey=$randomKey');
      print(response.data);
      print(response.statusCode);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return right(ManualChoserModel.fromJson(response.data));
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      print('exeption');
      print(e.message);
      return left(e.message.toString());
    }
  }
}
