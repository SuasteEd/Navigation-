import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';

class Intend extends StatefulWidget {
  const Intend({Key? key}) : super(key: key);

  @override
  _IntendState createState() => _IntendState();
}

late MapBoxNavigation _directions;

MapBoxOptions _options = MapBoxOptions(
    initialLatitude: 36.1175275,
    initialLongitude: -115.1839524,
    zoom: 13.0,
    tilt: 0.0,
    bearing: 0.0,
    enableRefresh: false,
    alternatives: true,
    voiceInstructionsEnabled: true,
    bannerInstructionsEnabled: true,
    allowsUTurnAtWayPoints: true,
    mode: MapBoxNavigationMode.drivingWithTraffic,
    mapStyleUrlDay: "https://url_to_day_style",
    mapStyleUrlNight: "https://url_to_night_style",
    units: VoiceUnits.imperial,
    simulateRoute: true,
    language: "en");

class _IntendState extends State<Intend> {
  @override
  void initState() {
    _directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _onRouteEvent(RouteEvent value) {}
}
