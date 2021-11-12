import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/key.dart';

import 'package:uber_clone/screens/maps/components/destination_entry.dart';
import 'package:uber_clone/screens/maps/components/ride_options.dart';
import 'package:uber_clone/services/global_model.dart';
import 'constants.dart';
import 'package:lottie/lottie.dart' as lot;

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  late PageController pagecontroller;
  @override
  void initState() {
    super.initState();
    pagecontroller = PageController();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      sourceIcon = await createMarkerImageFromAsset(context, true);
      destinationIcon = await createMarkerImageFromAsset(context, false);
      setState(() {});
    });
  }

  CameraPosition getInitialPosition(GlobalModel model) {
    return CameraPosition(
      target: LatLng(model.origin!.lat, model.origin!.long),
      zoom: 17.4746,
      bearing: 192.8334901395799,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Consumer<GlobalModel>(builder: (context, model, child) {
        return Column(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: model.processing
                    ? lot.Lottie.asset("assets/car.json")
                    : Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: getInitialPosition(model),
                            mapType: MapType.normal,
                            myLocationButtonEnabled: false,
                            polylines: model.polylines,
                            markers: <Marker>{
                              if (sourceIcon.toString() != "null")
                                createMarker(
                                    sourceIcon!,
                                    LatLng(
                                        model.origin!.lat, model.origin!.long),
                                    "source"),
                              if (destinationIcon.toString() != "null" &&
                                  model.destination != null)
                                createMarker(
                                    destinationIcon!,
                                    LatLng(model.destination!.lat,
                                        model.destination!.long),
                                    "destination"),
                            },
                            onMapCreated: (GoogleMapController gmapController) {
                              mapController = gmapController;
                              if (mapController != null &&
                                  model.fitPos != null) {
                                mapController?.animateCamera(model.fitPos!);
                              }
                            },
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 28,
                              child: IconButton(
                                iconSize: 28,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pagecontroller,
                  children: [
                    DestinationEntry(
                      model: model,
                      pageController: pagecontroller,
                    ),
                    RideOptions(model: model, pageController: pagecontroller)
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }
}
