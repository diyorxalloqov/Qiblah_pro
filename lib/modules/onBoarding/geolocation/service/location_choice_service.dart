// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geocoding/geocoding.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class LocationChooserService {
  Future<PositionInfo> getChosenLocation() async {
    PositionInfo rawJSON = PositionInfo(
        latitude: StorageRepository.getDouble(Keys.latitude),
        longitude: StorageRepository.getDouble(Keys.longitude),
        country: StorageRepository.getString(Keys.country),
        region: StorageRepository.getString(Keys.region),
        isPrecise: StorageRepository.getBool(Keys.isPrecise));

    print(rawJSON.country);
    print(rawJSON.region);
    print(rawJSON.latitude);
    print(rawJSON.isPrecise);
    print(rawJSON.longitude);

    return rawJSON;
  }

  Future<void> saveLocationChoice(PositionInfo? positionInfo) async {
    if (positionInfo == null) {
      // TODO instead emit error to the UI state
      return;
    }
    PositionInfo? positionToStore = positionInfo;
    if (positionInfo.country == null && positionInfo.region == null) {
      positionToStore = await addAddressInfo(positionInfo);
      if (positionToStore == null) {
        // TODO instead emit error to the UI state
        return;
      }
    }
    print('$positionInfo position info service');

    print("${positionToStore.country} position to store");
    await StorageRepository.putString(Keys.country, positionToStore.country!);
    await StorageRepository.putString(Keys.region, positionToStore.region!);
    await StorageRepository.putBool(Keys.isPrecise, positionInfo.isPrecise);
    await StorageRepository.putDouble(
        Keys.longitude, positionToStore.longitude);
    await StorageRepository.putDouble(Keys.latitude, positionToStore.latitude);
  }

  Future<PositionInfo?> addAddressInfo(PositionInfo? positionInfo) async {
    print(
        'addAddressInfo lat: ${positionInfo?.latitude} long: ${positionInfo?.longitude}');
    if (positionInfo == null) {
      // TODO instead emit error to UI state;
      return null;
    }
    // TODO add indexoutoufbound and null handling
    var placemark = (await placemarkFromCoordinates(
            positionInfo.latitude, positionInfo.longitude))
        .first;
    print(
        "${placemark.country} city ${placemark.administrativeArea} area ${positionInfo.isPrecise} location data is ");
    print(
        "${positionInfo.country} country ${positionInfo.region} region ${positionInfo.latitude} location data new ");

    return PositionInfo(
      country: placemark.country,
      region: placemark.administrativeArea,
      latitude: positionInfo.latitude,
      longitude: positionInfo.longitude,
      isPrecise: positionInfo.isPrecise,
    );
  }
}
