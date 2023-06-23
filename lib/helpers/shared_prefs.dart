import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:navigation/main.dart';

LatLng getCurrentLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}

String getCurrentAddressFromSharedPrefs() {
  return sharedPreferences.getString('current-address')!;
}


LatLng getTripLatLngFromSharedPrefs(String type) {
  // List sourceLocationList =
  //     json.decode(sharedPreferences.getString('source')!)['location'];
  // List destinationLocationList =
  //     json.decode(sharedPreferences.getString('destination')!)['location'];
  LatLng current = getCurrentLatLngFromSharedPrefs();
  LatLng source = LatLng(current.latitude, current.longitude);
  LatLng destination = const LatLng(21.1209049, -101.6638716);

  if (type == 'source') {
    return source;
  } else {
    return destination;
  }
}
