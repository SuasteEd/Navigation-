// ignore: library_prefixes
import 'package:latlong2/latlong.dart' as latLng;

class MapMarker {
  const MapMarker({
    required this.title,
    required this.address,
    required this.location,
  });

  final String title;
  final String address;
  final latLng.LatLng location;
}

final _locations = [
  latLng.LatLng(21.1498196, -101.7142442),
  latLng.LatLng(21.145997, -101.7097105),
  latLng.LatLng(21.1470949, -101.7120508),
  latLng.LatLng(21.1459465, -101.7128417)
];

final mapMarkers = [
  MapMarker(
      title: 'Axholutions',
      address: 'Vereda 102, Lomas del Sol, León, Gto. México',
      location: _locations[0]),
  MapMarker(
      title: 'Chilaca',
      address: 'Avenida Insurgente 208',
      location: _locations[1]),
  MapMarker(
      title: 'Tacos', address: 'Chilsdklfjsdklfjlaca', location: _locations[2]),
  MapMarker(
      title: 'Gerardo', address: 'Chilacfnsdfnsa', location: _locations[3]),
];
