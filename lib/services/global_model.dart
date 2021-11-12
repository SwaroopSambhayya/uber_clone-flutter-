import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/api/distance_matrix_api.dart';
import 'package:uber_clone/services/location.dart';

import '../key.dart';

class GlobalModel extends ChangeNotifier {
  Location? origin;
  Location? destination;
  Map<String, dynamic>? travelTimeInfo = {};
  List<Location> recents = [];
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  GoogleMapController? mapController;
  CameraUpdate? fitPos;

  bool processing = false;

  GlobalModel({this.origin, this.destination, this.travelTimeInfo});
  setOrigin(Location source) {
    origin = source;

    notifyListeners();
  }

  calculatePrice(int unitPrice) {
    int price = ((unitPrice *
                (double.parse(travelTimeInfo?['miles'].split(' ')[0]) *
                    1.60934)) /
            3)
        .round();
    return price.toString();
  }

  addToRecents() {
    if (recents.length <= 3 && !recents.contains(origin)) recents.add(origin!);
    notifyListeners();
  }

  setDestination(Location dest) async {
    processing = true;
    notifyListeners();
    destination = dest;

    await setPolyLines();
    travelTimeInfo = await getTravelTimeInformation(origin!, destination!);

    processing = false;
    notifyListeners();
  }

  setTravelTimeInfo(travellTime) {
    travelTimeInfo = travellTime;
    notifyListeners();
  }

  setPolyLines() async {
    PointLatLng source = PointLatLng(origin!.lat, origin!.long);
    polylineCoordinates = [];
    polylines = {};
    PointLatLng dest = PointLatLng(destination!.lat, destination!.long);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_MAPS_KEY, source, dest,
        optimizeWaypoints: true);
    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }

    Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        width: 5,
        color: Colors.black,
        points: polylineCoordinates);
    polylines.add(polyline);

    List<LatLng?> latngs = determinelatlan();
    fitPos = CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: latngs[0]!,
          northeast: latngs[1]!,
        ),
        50);
  }

  List<LatLng> determinelatlan() {
    LatLng southWest;
    LatLng northEast;
    double slat, slng, nlat, nlng;
    if (origin!.lat <= destination!.lat) {
      slat = origin!.lat;
      nlat = destination!.lat;
    } else {
      slat = destination!.lat;
      nlat = origin!.lat;
    }
    if (origin!.long <= destination!.long) {
      slng = origin!.long;
      nlng = destination!.long;
    } else {
      slng = destination!.long;
      nlng = origin!.long;
    }
    southWest = LatLng(slat, slng);
    northEast = LatLng(nlat, nlng);
    return [southWest, northEast];
  }

  Location? get getOrigin => origin;
  Location? get getDestination => destination;
  get getTravelTimeInfo => travelTimeInfo;
}
