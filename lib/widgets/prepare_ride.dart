import 'package:flutter/material.dart';

class PrepareRide extends StatefulWidget {
  const PrepareRide({Key? key}) : super(key: key);

  @override
  _PrepareRideState createState() => _PrepareRideState();

  //Declare a static fuction to reference setter from children
  static _PrepareRideState? of(BuildContext context) =>
      context.findAncestorStateOfType<_PrepareRideState>();
}

class _PrepareRideState extends State<PrepareRide> {
  bool isLoading = false;
  bool isEmptyResponse = true;
  bool hasResponded = false;
  bool isResponseForDestination = false;

  List responde = [];
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
