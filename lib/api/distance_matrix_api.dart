import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uber_clone/key.dart';
import 'package:uber_clone/services/location.dart';

Future getTravelTimeInformation(Location origin, Location destination) async {
  var url = Uri.https('maps.googleapis.com', 'maps/api/distancematrix/json', {
    'units': 'imperial',
    'destinations': destination.description,
    'origins': origin.description,
    'key': GOOGLE_MAPS_KEY
  });
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data["rows"][0]["elements"][0]["duration"]["text"]);
    return {
      "miles": data["rows"][0]["elements"][0]["distance"]["text"],
      "travelTime": data["rows"][0]["elements"][0]["duration"]["text"]
    };
  }
}
