import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:navigation/models/map_marker.dart';

class AnimatedMarkersMap extends StatelessWidget {
  const AnimatedMarkersMap({Key? key}) : super(key: key);

  List<Marker> _builMarkers() {
    final _markerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];
      //_markerList.add(Marker(point: mapItem.location, builder: builder))
    }
    return _markerList;
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _builMarkers();
    return Container();
  }
}
