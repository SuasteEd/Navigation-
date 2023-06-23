import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:navigation/constants.dart';
import 'package:http/http.dart' as http;
import '../helpers/exceptions.dart';
import '../models/geo_coding.dart';

String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken = mapBoxToken;

Future<Map> getReverseGeocodingGivenLatLngUsingMapbox(LatLng latLng) async {
  String query = '${latLng.longitude},${latLng.latitude}';
  String url = '$baseUrl/$query.json?access_token=$accessToken';
  Uri urlUri = Uri.parse(url);
  var response = await http.get(urlUri);
  var data = GeoCoding.fromJson(response.body);
  var features = data.features[0];
  Map revGeocode = {
    'name': features.text,
    'address': features.address,
    'place': features.placeName,
    'location': latLng
  };
  return revGeocode;
}
