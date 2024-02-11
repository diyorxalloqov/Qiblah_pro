import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Stream<ServiceStatus> serviceStatus() => Geolocator.getServiceStatusStream();

  // Test if location services are enabled.
  Future<bool> isGPSEnabled() => Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> isPermissionGranted() => Geolocator.checkPermission();

  Future<bool> isPrecise() async {
    var accuracy = await Geolocator.getLocationAccuracy();
    return accuracy == LocationAccuracyStatus.precise;
  }

  Future<LocationPermission> requestPermissions() => Geolocator.requestPermission();

  Future<LocationAccuracyStatus> getAccuracy() => Geolocator.getLocationAccuracy();

  Future<Position> getLocation() => Geolocator.getCurrentPosition();

  Future<void> askToIncreaseAccuracy() async {
    await askToPermitInSettings();
  }

  Future<void> askToEnableLocationService() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> askToPermitInSettings() async {
    await Geolocator.openAppSettings();
  }
}
