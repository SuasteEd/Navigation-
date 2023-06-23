import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:navigation/helpers/mapbox_handler.dart';
import 'package:navigation/widgets/review_Ride.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
import 'package:navigation/helpers/shared_prefs.dart';

import '../models/map_marker.dart';

const mapboxAccessToken =
    'pk.eyJ1IjoiZS1zdWFzdGUiLCJhIjoiY2xkMG9qMTV2MDM5cTNxcDdpemUyZnoxbyJ9.wx4B0HJei5h2bxWhApXZ0Q';

const mapboxStyle = 'mapbox/navigation-night-v1';

const markerSizeExpanded = 55.0;

const markerSizeShrink = 35.0;

class Navegar extends StatefulWidget {
  const Navegar({Key? key}) : super(key: key);

  @override
  State<Navegar> createState() => _NavegarState();
}

class _NavegarState extends State<Navegar> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  final myLocation = getCurrentLatLngFromSharedPrefs();

  final _pageController = PageController();

  int _selectedIndex = 0;

  List<Marker> _builMarkers() {
    final markerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];
      markerList.add(
        Marker(
            height: markerSizeExpanded,
            width: markerSizeExpanded,
            point: mapItem.location,
            builder: (_) {
              return GestureDetector(
                onTap: () {
                  _selectedIndex = i;
                  _pageController.animateToPage(i,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut);
                  setState(() {});
                  //print('Selected marker ${mapItem.title}');
                },
                child: _LocationMarker(
                  selected: _selectedIndex == i,
                ),
              );
            }),
      );
    }
    return markerList;
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final markers = _builMarkers();
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 16,
              center: lat_lng.LatLng(myLocation.latitude, myLocation.longitude),
            ),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': mapboxAccessToken,
                  'id': mapboxStyle,
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    height: 60,
                    width: 60,
                    point: lat_lng.LatLng(
                        myLocation.latitude, myLocation.longitude),
                    builder: (_) {
                      return _MyLocationMarker(_animationController);
                    },
                  ),
                ],
              ),
              MarkerLayer(
                markers: markers,
              ),
            ],
          ),
          //Page View
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.2,
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mapMarkers.length,
              itemBuilder: (context, index) {
                final item = mapMarkers[index];
                return _MapItemDetails(
                  mapMarker: item,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Navegar',
        backgroundColor: Colors.white,
        onPressed: () async {
          Map modifiedResponse = await getDirectionsAPIResponse(
              LatLng(21.1498247, -101.7140443),
              LatLng(21.150182, -101.7145288));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ReviewRide(
                        modifiedResponse: modifiedResponse,
                      )));
        },
        child: const Center(
          child: Icon(
            size: 50,
            Icons.assistant_navigation,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class _LocationMarker extends StatelessWidget {
  const _LocationMarker({Key? key, this.selected = false}) : super(key: key);
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final size = selected ? markerSizeExpanded : markerSizeShrink;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 300),
        child: Image.asset('assets/marker.png'),
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({Key? key, required this.mapMarker}) : super(key: key);
  final MapMarker mapMarker;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      //height: size.height * 0.18,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Folio 244',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              mapMarker.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.w800),
            ),
            Row(
              children: [
                const Icon(Icons.room_outlined),
                SizedBox(
                  width: size.width * 0.87,
                  child: Text(
                    mapMarker.address,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              children: const [
                Text(
                  '18/01/2021',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '12:00 - 1:30 PM',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}

class _MyLocationMarker extends AnimatedWidget {
  _MyLocationMarker(
    Animation<double> animation, {
    Key? key,
  }) : super(key: key, listenable: animation);

  final tag = getCurrentAddressFromSharedPrefs();
  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final lerp = lerpDouble(0.5, 1.0, value)!;
    const size = 50.0;
    return GestureDetector(
      onTap: () {
        QuickAlert.show(
          context: context,
          title: 'Estás aquí',
          confirmBtnText: 'Ok',
          type: QuickAlertType.success,
          text: tag,
        );
      },
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Container(
                height: size * lerp,
                width: size * lerp,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
