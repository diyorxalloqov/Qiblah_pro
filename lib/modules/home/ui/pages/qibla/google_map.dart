import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qiblah_pro/core/constants/keys.dart';
import 'package:qiblah_pro/core/db/shared_preferences.dart';

class SmallGoogleMap extends StatefulWidget {
  const SmallGoogleMap({Key? key}) : super(key: key);

  @override
  State<SmallGoogleMap> createState() => MapSampleState();
}

class MapSampleState extends State<SmallGoogleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  PolylinePoints polylinePoints = PolylinePoints();

  double longitude = StorageRepository.getDouble(Keys.longitude) ?? 0.0;
  double latitude = StorageRepository.getDouble(Keys.latitude) ?? 0.0;

  late CameraPosition _kGooglePlex;

  Map<MarkerId, Marker> markers = {};
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _drawPolyline(
            initialPoint: LatLng(latitude, longitude),
            destinationPoint: const LatLng(21.4224779, 39.8251832),
          );
    _kGooglePlex =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 14.0);
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
          // Draw polyline after map has been created
          _drawPolyline(
            initialPoint: LatLng(latitude, longitude),
            destinationPoint: LatLng(21.4224779, 39.8251832),
          );
          _controller.complete(controller);
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  Future<void> _drawPolyline(
      {required LatLng initialPoint, required LatLng destinationPoint}) async {
    polylines.clear();
    polylineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCrx4cv3JNjbMDLEJPpQiUyMtLFdj37Egc',
      PointLatLng(initialPoint.latitude, initialPoint.longitude),
      PointLatLng(destinationPoint.latitude, destinationPoint.longitude),
      travelMode: TravelMode.walking,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      PolylineId id = PolylineId('polyline');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 4,
      );

      setState(() {
        polylines[id] = polyline;
      });
    }
  }
}
