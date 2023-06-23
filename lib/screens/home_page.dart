import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:navigation/widgets/review_ride_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  final navigationView = 'mapbox://styles/e-suaste/cld1y8tut000o01mjmxngjjld';
  final streetView = 'mapbox://styles/e-suaste/cld1ybzmm003501qemw9j287s';
  //
  final center = const LatLng(20.6762, -103.3469);
  //
  late MapboxMapController mapController;
  //
  void _onMapCrated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: [
          SizedBox(
            child: MapboxMap(
              compassEnabled: true,
              myLocationEnabled: true,
              trackCameraPosition: true,
              styleString: streetView,
              onMapCreated: _onMapCrated,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 14,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
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
                      'Carlos Aldaña',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.room_outlined),
                        Text(
                          'Avenida universidad, 202',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                    const SizedBox(
                      height: 50,
                    )
                    // Center(
                    //   child: IconButton(
                    //     iconSize: 65,
                    //     color: Colors.blue,
                    //     icon: const Icon(Icons.assistant_navigation),
                    //     onPressed: () {
                    //       print('d');
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Navegar',
      //   backgroundColor: Colors.white,
      //   onPressed: () {},
      //   child: const Center(
      //     child: Icon(
      //       size: 50,
      //       Icons.assistant_navigation,
      //       color: Colors.blue,
      //     ),
      //   ),
      // ),
      floatingActionButton: floatingDirectionsButton(context),
    );
  }
}
