import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:navigation/screens/Ride.dart';

class TurnByTurn extends StatefulWidget {
  const TurnByTurn({Key? key}) : super(key: key);

  @override
  _TurnByTurnState createState() => _TurnByTurnState();
}

class _TurnByTurnState extends State<TurnByTurn> {
  //Waypoints to mark trip start and end
  final LatLng source = const LatLng(21.1495134, -101.7182171);
  final LatLng destination = const LatLng(21.1495134, -101.7182171);
  late WayPoint sourceWayPoint, destinationWayPoint;
  var wayPoints = <WayPoint>[];

  //Config variables for MapBox Navigation
  late MapBoxNavigation directions;
  late MapBoxOptions options;
  late double distanceRemaining, durationRemaining;
  late MapBoxNavigationViewController controller;
  final bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> initilize() async {
    if (!mounted) return;
    //Setup directions and options
    directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: true,
        language: 'es');

    //Configure waypoints
    sourceWayPoint = WayPoint(
        name: "Source", latitude: source.latitude, longitude: source.longitude);
    destinationWayPoint = WayPoint(
        name: "Destination",
        latitude: destination.latitude,
        longitude: destination.longitude);

    //Start the trip
    await directions.startNavigation(wayPoints: wayPoints, options: options);
  }

  @override
  Widget build(BuildContext context) {
    return const RateRide();
  }

  Future<void> _onRouteEvent(RouteEvent e) async {
    distanceRemaining = await directions.distanceRemaining;
    durationRemaining = await directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }

    //Refresh UI
    setState(() {});
  }
}
