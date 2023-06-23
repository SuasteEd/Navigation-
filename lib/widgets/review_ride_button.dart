import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:navigation/screens/directions.dart';
import 'package:navigation/widgets/review_ride.dart';

import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';

Widget floatingDirectionsButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.local_taxi),
      onPressed: () async {
        LatLng sourceLatLng = getCurrentLatLngFromSharedPrefs();
        LatLng destinationLatLng = const LatLng(21.1209049, -101.6638716);
        Map modifiedResponse =
            await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    Directions(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Navegación'));
}
