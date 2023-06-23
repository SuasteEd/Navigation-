// // ----------------------------- Mapbox Reverse Geocoding -----------------------------
// import 'dart:convert';

// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:navigation/models/geo_coding.dart';

// import '../request/mapbox_geocoding.dart';

// Future<Map> getParsedReverseGeocoding(LatLng latLng) async {
//   var response = await getReverseGeocodingGivenLatLngUsingMapbox(latLng);
//   var data = Feature.fromJson(response);
//   print(data.placeName);
//   Map revGeocode = {
//     'name': data.text,
//     'address': data.address,
//     'place': data.placeName,
//     'location': latLng
//   };
//   return revGeocode;
// }

// ----------------------------- Mapbox Directions API -----------------------------
import 'package:mapbox_gl/mapbox_gl.dart';

import 'mapbox_directions.dart';

Future<Map> getDirectionsAPIResponse(
    LatLng sourceLatLng, LatLng destinationLatLng) async {
  final response =
      await getCyclingRouteUsingMapBox(sourceLatLng, destinationLatLng);
  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  }; 
  return modifiedResponse;
}

LatLng getCenterCoordinatesForPolyline(Map geometry) {
  List coordinates = geometry['coordinates'];
  int pos = (coordinates.length / 2).round();
  return LatLng(coordinates[pos][1], coordinates[pos][0]);
}