import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/service/geolocation_service.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/service/location_choice_service.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  GeolocationCubit() : super(const GeolocationState()) {
    listenServiceStatus();
  }

  final GeolocatorService _geolocationManager = GeolocatorService();
  StreamSubscription<ServiceStatus>? _serviceStatusSubscription;

  LocationInfo _locationInfo = LocationInfo(LocationStatusEnum.notRequested);
  bool _isWaitingForPermission = false;
  bool _requirePreciseLocation = true;

  LocationInfo get locationInfo => _locationInfo;
  bool get isWaitingForPermission => _isWaitingForPermission;

  set locationInfo(LocationInfo value) {
    if (_locationInfo.position == null) {
      _locationInfo = value;
    }
  }

  set requirePreciseLocation(bool value) {
    _requirePreciseLocation = value;
  }

  Future<void> determineLocation() async {
    if (!await _geolocationManager.isGPSEnabled()) {
      _updateLocationStatus(LocationStatusEnum.gpsDisabled);
      return;
    }

    LocationPermission permission =
        await _geolocationManager.isPermissionGranted();
    if (permission == LocationPermission.denied) {
      permission = await _geolocationManager.requestPermissions();
      if (permission == LocationPermission.denied) {
        _updateLocationStatus(LocationStatusEnum.denied);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _updateLocationStatus(LocationStatusEnum.deniedForever);
      return;
    }

    var isPrecise = (await _geolocationManager.getAccuracy()) ==
        LocationAccuracyStatus.precise;
    if (_requirePreciseLocation && !isPrecise) {
      _updateLocationStatus(LocationStatusEnum.onlyApproximate);
      return;
    }

    _updateLocationStatus(LocationStatusEnum.waiting);

    Position location = await _geolocationManager.getLocation();
    var placemark =
        (await placemarkFromCoordinates(location.latitude, location.longitude))
            .first;
    _locationInfo = LocationInfo(
      LocationStatusEnum.available,
      position: PositionInfo(
          latitude: location.latitude,
          longitude: location.longitude,
          isPrecise: isPrecise,
          country: placemark.country,
          region: placemark.administrativeArea),
    );
    print("${location.longitude} longtitude");
    print("${location.latitude} longtitude");
    print("${_locationInfo.position?.country} position get");

    emit(state.copyWith(locationInfo: _locationInfo));
  }

  void askToEnableGPS() async {
    waitForPermission();
    await _geolocationManager.askToEnableLocationService();
  }

  void askToGivePermissionsInSettings() async {
    waitForPermission();
    await determineLocation();
    switch (_locationInfo.locationStatus) {
      case LocationStatusEnum.denied:
        await _geolocationManager.askToPermitInSettings();
      case LocationStatusEnum.deniedForever:
        await _geolocationManager.askToPermitInSettings();
      default:
        emit(state.copyWith(locationInfo: _locationInfo));
    }
  }

  void askToIncreaseAccuracy() async {
    waitForPermission();
    await determineLocation();
    if (_locationInfo.locationStatus == LocationStatusEnum.onlyApproximate) {
      await _geolocationManager.askToIncreaseAccuracy();
    }
  }

  void waitForPermission() => _isWaitingForPermission = true;

  void stopWaitingForPermission() => _isWaitingForPermission = false;

  /// when GPS is enabled.
  void listenServiceStatus() {
    if (_serviceStatusSubscription != null) {
      return;
    }
    _serviceStatusSubscription =
        _geolocationManager.serviceStatus().handleError((error) {
      locationInfo = LocationInfo(LocationStatusEnum.failed);
      emit(state.copyWith(locationInfo: _locationInfo));
    }).listen((serviceStatus) {
      if (serviceStatus == ServiceStatus.enabled) {
        determineLocation();
      } else {
        locationInfo = LocationInfo(LocationStatusEnum.gpsDisabled);
        emit(state.copyWith(locationInfo: _locationInfo));
      }
    });
  }

  void _updateLocationStatus(LocationStatusEnum locationStatus) {
    _locationInfo = LocationInfo(locationStatus);
    emit(state.copyWith(locationInfo: _locationInfo));
  }

  /// location

  final LocationChooserService locationChooserService =
      LocationChooserService();

  List<PositionInfo>? _searchResults = [];

  List<PositionInfo>? get searchResults => _searchResults;

  void searchRegionByTitle(String region) async {
    print('request keett');
    emit(state.copyWith(status: ActionStatus.isLoading));

    // TODO rename foundAddress into a more meaningful name to explain that these are results when user searched for a region
    try {
      if (region.isEmpty) {
        return;
      }
      var foundAddresses = await locationFromAddress(region);
      List<PositionInfo> results = [];
      for (var address in foundAddresses) {
        var placemark = (await placemarkFromCoordinates(
                address.latitude, address.longitude))
            .first;
        results.add(PositionInfo(
            region: placemark.administrativeArea,
            country: placemark.country,
            latitude: address.latitude,
            longitude: address.longitude,
            isPrecise: false));
      }
      _searchResults = results;
      emit(state.copyWith(
          status: ActionStatus.isSuccess, positionList: results));
    } on NoResultFoundException {
      // TODO catch also network failure exception
      _searchResults = List.empty();
      emit(state.copyWith(status: ActionStatus.isError));
    }
    print(state.status);
  }

  Future<PositionInfo?> getChosenLocation() async =>
      await locationChooserService.getChosenLocation();

  void saveLocationChoice(PositionInfo? positionInfo) {
    locationChooserService.saveLocationChoice(positionInfo);
  }

  Future<PositionInfo?> addAddressInfo(PositionInfo? positionInfo) async {
    var s = await locationChooserService.addAddressInfo(positionInfo);
    print(s!.country);
    print(s.isPrecise);
    print(s.latitude);
    print(s.longitude);
    print(s.region);
    return s;
  }
}
