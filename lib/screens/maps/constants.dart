import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createMarkerImageFromAsset(
    BuildContext context, bool forSource) async {
  BitmapDescriptor? markerIcon;
  final ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context, size: const Size.square(48));
  await BitmapDescriptor.fromAssetImage(imageConfiguration,
          forSource ? 'assets/source.png' : 'assets/destination.png')
      .then((BitmapDescriptor bitmap) {
    markerIcon = bitmap;
  });
  return markerIcon!;
}

Marker createMarker(BitmapDescriptor icon, LatLng pos, String id) {
  return Marker(
    markerId: MarkerId(id),
    position: pos,
    icon: icon,
  );
}
