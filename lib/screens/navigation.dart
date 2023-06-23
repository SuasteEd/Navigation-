import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:navigation/main.dart';
import 'package:navigation/request/mapbox_geocoding.dart';
import 'package:navigation/screens/navegar.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  void initState() {
    initializeLocationAndSave();
    super.initState();
  }

  void initializeLocationAndSave() async {
    //Ensure all permissions are collected for location
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionsGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionsGranted = await location.hasPermission();
    if (permissionsGranted == PermissionStatus.denied) {
      permissionsGranted = await location.requestPermission();
    }

    //Get the current user location
    LocationData locationData = await location.getLocation();
    LatLng currentLocation =
        LatLng(locationData.latitude!, locationData.longitude!);

    //Get the currente user address
    String currentAddress = (await getReverseGeocodingGivenLatLngUsingMapbox(
        currentLocation))['place'];

    //Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', locationData.latitude!);
    sharedPreferences.setDouble('longitude', locationData.longitude!);
    sharedPreferences.setString('current-address', currentAddress);

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => Navegar(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/moto.gif'),
      ),
    );
  }
}
