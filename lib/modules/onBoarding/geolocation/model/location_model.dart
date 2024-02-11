import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class PositionInfo {
  final String? region;
  final String? country;
  final double latitude;
  final double longitude;
  final bool isPrecise;

  PositionInfo(
      {this.region,
      this.country,
      required this.latitude,
      required this.longitude,
      required this.isPrecise});

  factory PositionInfo.fromJson(Map<String, dynamic> json) {
    return PositionInfo(
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      isPrecise: json['isPrecise'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'region': region,
        'country': country,
        'latitude': latitude,
        'longitude': longitude,
        'isPrecise': isPrecise,
      };

  @override
  String toString() {
    return '$region, $country';
  }
}

class LocationInfo {
  final PositionInfo? position;
  final LocationStatusEnum locationStatus;

  LocationInfo(this.locationStatus, {this.position});
}
