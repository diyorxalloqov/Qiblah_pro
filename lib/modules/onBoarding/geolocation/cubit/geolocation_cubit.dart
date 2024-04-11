// import 'dart:async';

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
// import 'package:qiblah_pro/modules/onBoarding/geolocation/model/auto_complete_model.dart';
// import 'package:qiblah_pro/modules/onBoarding/geolocation/service/geolocation_service.dart';
// import 'package:qiblah_pro/modules/onBoarding/geolocation/service/location_choice_service.dart';

// part 'geolocation_state.dart';

// class GeolocationCubit extends Cubit<GeolocationState> {
//   GeolocationCubit() : super(const GeolocationState()) {
//     listenServiceStatus();
//   }

//   final GeolocatorService _geolocationManager = GeolocatorService();
//   StreamSubscription<ServiceStatus>? _serviceStatusSubscription;

//   LocationInfo _locationInfo = LocationInfo(LocationStatusEnum.notRequested);
//   bool _isWaitingForPermission = false;
//   bool _requirePreciseLocation = true;

//   LocationInfo get locationInfo => _locationInfo;
//   bool get isWaitingForPermission => _isWaitingForPermission;

//   set locationInfo(LocationInfo value) {
//     if (_locationInfo.position == null) {
//       _locationInfo = value;
//     }
//   }

//   set requirePreciseLocation(bool value) {
//     _requirePreciseLocation = value;
//   }

//   Future<void> determineLocation() async {
//     if (!await _geolocationManager.isGPSEnabled()) {
//       _updateLocationStatus(LocationStatusEnum.gpsDisabled);
//       return;
//     }

//     //// Android

//     if (Platform.isAndroid) {
//       LocationPermission permission =
//           await _geolocationManager.isPermissionGranted();
//       if (permission == LocationPermission.denied) {
//         permission = await _geolocationManager.requestPermissions();
//         if (permission == LocationPermission.denied) {
//           _updateLocationStatus(LocationStatusEnum.denied);
//           return;
//         }
//       }
//     }

//     ///

//     // Location permission handling for iOS
//     if (Platform.isIOS) {
//       try {
//         LocationPermission permission =
//             await _geolocationManager.isPermissionGranted();
//         if (permission == LocationPermission.denied ||
//             permission == LocationPermission.deniedForever) {
//           // Handle permission denied scenario for iOS
//           await _geolocationManager.askToPermitInSettings();
//           return;
//         }
//       } on PermissionRequestInProgressException catch (e) {
//         debugPrint(e.message);
//         // Handle permission request already in progress for iOS
//         return;
//       }
//     }

//     var isPrecise = (await _geolocationManager.getAccuracy()) ==
//         LocationAccuracyStatus.precise;
//     if (_requirePreciseLocation && !isPrecise) {
//       _updateLocationStatus(LocationStatusEnum.onlyApproximate);
//       return;
//     }

//     _updateLocationStatus(LocationStatusEnum.waiting);

//     Position location = await _geolocationManager.getLocation();
//     var placemark =
//         (await placemarkFromCoordinates(location.latitude, location.longitude))
//             .first;
//     _locationInfo = LocationInfo(
//       LocationStatusEnum.available,
//       position: PositionInfo(
//           latitude: location.latitude,
//           longitude: location.longitude,
//           isPrecise: isPrecise,
//           country: placemark.country,
//           region: placemark.administrativeArea),
//     );
//     debugPrint("${location.longitude} longtitude");
//     debugPrint("${location.latitude} longtitude");
//     debugPrint("${_locationInfo.position?.country} position get");

//     emit(state.copyWith(locationInfo: _locationInfo));
//   }

//   void askToEnableGPS() async {
//     waitForPermission();
//     await _geolocationManager.askToEnableLocationService();
//   }

//   void askToGivePermissionsInSettings() async {
//     waitForPermission();
//     await determineLocation();
//     if (Platform.isIOS &&
//         (_locationInfo.locationStatus == LocationStatusEnum.denied ||
//             _locationInfo.locationStatus == LocationStatusEnum.deniedForever)) {
//       await _geolocationManager.askToPermitInSettings();
//       return;
//     }
//     switch (_locationInfo.locationStatus) {
//       case LocationStatusEnum.denied:
//         await _geolocationManager.askToPermitInSettings();
//       case LocationStatusEnum.deniedForever:
//         await _geolocationManager.askToPermitInSettings();
//       default:
//         emit(state.copyWith(locationInfo: _locationInfo));
//     }
//   }

//   void askToIncreaseAccuracy() async {
//     waitForPermission();
//     await determineLocation();
//     if (_locationInfo.locationStatus == LocationStatusEnum.onlyApproximate) {
//       await _geolocationManager.askToIncreaseAccuracy();
//     }
//   }

//   void waitForPermission() => _isWaitingForPermission = true;

//   void stopWaitingForPermission() => _isWaitingForPermission = false;

//   /// when GPS is enabled.
//   void listenServiceStatus() {
//     if (_serviceStatusSubscription != null) {
//       return;
//     }
//     _serviceStatusSubscription =
//         _geolocationManager.serviceStatus().handleError((error) {
//       locationInfo = LocationInfo(LocationStatusEnum.failed);
//       emit(state.copyWith(locationInfo: _locationInfo));
//     }).listen((serviceStatus) {
//       if (serviceStatus == ServiceStatus.enabled) {
//         determineLocation();
//       } else {
//         locationInfo = LocationInfo(LocationStatusEnum.gpsDisabled);
//         emit(state.copyWith(locationInfo: _locationInfo));
//       }
//     });
//   }

//   void _updateLocationStatus(LocationStatusEnum locationStatus) {
//     _locationInfo = LocationInfo(locationStatus);
//     emit(state.copyWith(locationInfo: _locationInfo));
//   }

//   /// location

//   final LocationChooserService locationChooserService =
//       LocationChooserService();

//   List<PositionInfo>? _searchResults = [];

//   List<PositionInfo>? get searchResults => _searchResults;

//   void searchRegionByTitle(String region) async {
//     debugPrint('request keett');
//     emit(state.copyWith(status: ActionStatus.isLoading));

//     // TODO rename foundAddress into a more meaningful name to explain that these are results when user searched for a region
//     try {
//       if (region.isEmpty) {
//         return;
//       }
//       var foundAddresses = await locationFromAddress(region);
//       List<PositionInfo> results = [];
//       for (var address in foundAddresses) {
//         var placemark = (await placemarkFromCoordinates(
//                 address.latitude, address.longitude))
//             .first;
//         results.add(PositionInfo(
//             region: placemark.administrativeArea,
//             country: placemark.country,
//             latitude: address.latitude,
//             longitude: address.longitude,
//             isPrecise: false));
//       }
//       _searchResults = results;
//       emit(state.copyWith(
//           status: ActionStatus.isSuccess, positionList: results));
//     } on NoResultFoundException {
//       // TODO catch also network failure exception
//       _searchResults = List.empty();
//       emit(state.copyWith(status: ActionStatus.isError));
//     }
//     debugPrint(state.status);
//   }

//   Future<PositionInfo?> getChosenLocation() async =>
//       await locationChooserService.getChosenLocation();

//   void saveLocationChoice(PositionInfo? positionInfo) {
//     locationChooserService.saveLocationChoice(positionInfo);
//   }

//   Future<PositionInfo?> addAddressInfo(PositionInfo? positionInfo) async {
//     var s = await locationChooserService.addAddressInfo(positionInfo);
//     debugPrint(s!.country);
//     debugPrint(s.isPrecise);
//     debugPrint(s.latitude);
//     debugPrint(s.longitude);
//     debugPrint(s.region);
//     return s;
//   }
// }

import 'package:geolocator/geolocator.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/model/auto_complete_model.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/service/geolocation_service.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/service/location_choice_service.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  GeolocationCubit() : super(const GeolocationState()) {
    listenServiceStatus();
    getSavedLocation();
  }

  final GeolocatorService _geolocationManager = GeolocatorService();
  StreamSubscription<ServiceStatus>? _serviceStatusSubscription;
  final LocationService _locationService = LocationService();

  bool _isWaitingForPermission = false;
  bool _requirePreciseLocation = true;

  bool get isWaitingForPermission => _isWaitingForPermission;
  LocationStatusEnum _locationInfo = LocationStatusEnum.notRequested;

  set requirePreciseLocation(bool value) {
    _requirePreciseLocation = value;
  }

  Future<void> determineLocation() async {
    if (!await _geolocationManager.isGPSEnabled()) {
      _updateLocationStatus(LocationStatusEnum.gpsDisabled);
      return;
    }

    //// Android

    if (Platform.isAndroid) {
      LocationPermission permission =
          await _geolocationManager.isPermissionGranted();
      if (permission == LocationPermission.denied) {
        permission = await _geolocationManager.requestPermissions();
        if (permission == LocationPermission.denied) {
          _updateLocationStatus(LocationStatusEnum.denied);
          return;
        }
      }
    }

    ///

    // Location permission handling for iOS
    if (Platform.isIOS) {
      try {
        LocationPermission permission =
            await _geolocationManager.isPermissionGranted();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          // Handle permission denied scenario for iOS
          await _geolocationManager.askToPermitInSettings();
          return;
        }
      } on PermissionRequestInProgressException catch (e) {
        debugPrint(e.message);
        // Handle permission request already in progress for iOS
        return;
      }
    }

    var isPrecise = (await _geolocationManager.getAccuracy()) ==
        LocationAccuracyStatus.precise;
    if (_requirePreciseLocation && !isPrecise) {
      _updateLocationStatus(LocationStatusEnum.onlyApproximate);
      return;
    }

    _updateLocationStatus(LocationStatusEnum.waiting);

    var res = await _locationService.autoChoiceLocation();
    res.fold(
        (l) => emit(state.copyWith(
            status: ActionStatus.isError,
            error: l,
            locationStatusEnum: LocationStatusEnum.failed)), (r) {
      emit(state.copyWith(
          autoChoiceLocationModel: r,
          status: ActionStatus.isSuccess,
          locationStatusEnum: LocationStatusEnum.available));
      saveLocationAuto(r);
    });
  }

  void askToEnableGPS() async {
    waitForPermission();
    await _geolocationManager.askToEnableLocationService();
  }

  void askToGivePermissionsInSettings() async {
    waitForPermission();
    await determineLocation();
    if (Platform.isIOS &&
        (_locationInfo == LocationStatusEnum.denied ||
            _locationInfo == LocationStatusEnum.deniedForever)) {
      await _geolocationManager.askToPermitInSettings();
      return;
    }
    switch (_locationInfo) {
      case LocationStatusEnum.denied:
        await _geolocationManager.askToPermitInSettings();
      case LocationStatusEnum.deniedForever:
        await _geolocationManager.askToPermitInSettings();
      default:
        emit(state.copyWith(locationStatusEnum: _locationInfo));
    }
  }

  void askToIncreaseAccuracy() async {
    waitForPermission();
    await determineLocation();
    if (_locationInfo == LocationStatusEnum.onlyApproximate) {
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
      _locationInfo = LocationStatusEnum.failed;
      emit(state.copyWith(locationStatusEnum: _locationInfo));
    }).listen((serviceStatus) {
      if (serviceStatus == ServiceStatus.enabled) {
        determineLocation();
      } else {
        _locationInfo = LocationStatusEnum.gpsDisabled;
        emit(state.copyWith(locationStatusEnum: _locationInfo));
      }
    });
  }

  void _updateLocationStatus(LocationStatusEnum locationStatus) {
    _locationInfo = locationStatus;
    emit(state.copyWith(locationStatusEnum: _locationInfo));
  }

  /// location

  void searchRegionByTitle(String place) async {
    debugPrint('request keett');
    emit(state.copyWith(manualStatus: ActionStatus.isLoading));

    var res = await _locationService.manuaChoiceLocation(place);
    res.fold(
        (l) =>
            emit(state.copyWith(manualStatus: ActionStatus.isError, error: l)),
        (r) => emit(state.copyWith(
            manualStatus: ActionStatus.isSuccess, manualChoserModel: r)));
    debugPrint("${state.status}");
  }

  void saveLocationManual(ManualChoserModel? positionInfo, int index) async {
    await StorageRepository.putString(
        Keys.country, positionInfo?.results?[index].formatted ?? '');
    await StorageRepository.putString(
        Keys.capital, positionInfo?.results?[index].city ?? '');
    await StorageRepository.putDouble(
        Keys.longitude, positionInfo?.results?[index].lon ?? 0);
    await StorageRepository.putDouble(
        Keys.latitude, positionInfo?.results?[index].lat ?? 0);
  }

  void saveLocationAuto(
      AutoChoiceLocationModel? autoChoiceLocationModel) async {
    await StorageRepository.putString(
        Keys.country, autoChoiceLocationModel?.country?.name ?? '');
    await StorageRepository.putString(
        Keys.capital, autoChoiceLocationModel?.country?.capital ?? '');
    await StorageRepository.putDouble(
        Keys.longitude, autoChoiceLocationModel?.location?.longitude ?? 0);
    await StorageRepository.putDouble(
        Keys.latitude, autoChoiceLocationModel?.location?.latitude ?? 0);
  }

  void getSavedLocation() {
    emit(state.copyWith(
        country: StorageRepository.getString(Keys.country),
        capital: StorageRepository.getString(Keys.capital),
        latitude: StorageRepository.getDouble(Keys.latitude),
        longtitude: StorageRepository.getDouble(Keys.longitude)));
  }
}
