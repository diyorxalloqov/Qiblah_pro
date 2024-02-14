import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qiblah_pro/core/constants/keys.dart';
import 'package:qiblah_pro/core/db/shared_preferences.dart';

class SmallGoogleMap extends StatefulWidget {
  const SmallGoogleMap({super.key});

  @override
  State<SmallGoogleMap> createState() => MapSampleState();
}

class MapSampleState extends State<SmallGoogleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  PolylinePoints polylinePoints = PolylinePoints();

  double longitude = StorageRepository.getDouble(Keys.longitude);
  double latitude = StorageRepository.getDouble(Keys.latitude);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.311081, 69.240562),
    zoom: 14.4746,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  Map<MarkerId, Marker> markers = {};

  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  void _addMarkers(LatLng point, String markerName) {
    // Define marker properties
    final MarkerId markerId = MarkerId(markerName);
    final Marker marker = Marker(
        markerId: markerId,
        position: point,
        infoWindow: InfoWindow(
          title: markerName,
          snippet: 'Marker Snippet',
        ),
        onTap: () {});

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (point) {
          _addMarkers(point, "Destination");
          _drawPolyline(
              initialPoint: LatLng(latitude, longitude),
              destinationPoint: point);
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  // Future<void> _goToTheMyLocation() async {
  //   LocationData newLocation = await location.getLocation();
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           target: LatLng(
  //             newLocation.latitude!,
  //             newLocation.longitude!,
  //           ),
  //           zoom: 20),
  //     ),
  //   );
  // }

  Future<void> _drawPolyline(
      {required LatLng initialPoint, required LatLng destinationPoint}) async {
    polylines.clear();
    polylineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBxYMqIM6G4C5SIWroVFvbZ-7Qpu8AFOvM",
        PointLatLng(initialPoint.latitude, initialPoint.longitude),
        PointLatLng(destinationPoint.latitude, destinationPoint.longitude),
        travelMode: TravelMode.walking);

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      PolylineId id = const PolylineId('polyline');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 4,
      );

      setState(() {
        polylines[id] = polyline;
      });
    }
  }
}
