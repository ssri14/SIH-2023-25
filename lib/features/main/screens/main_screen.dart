import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();



  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(23.814, 86.441),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 8,
      ),
      bottomNavigationBar: const GNav(tabs: [
        GButton(
          icon: Icons.home_outlined,
          text: "home",
        ),
        GButton(
          icon: Icons.home_outlined,
          text: "sos",
        ),
        GButton(
          icon: Icons.home_outlined,
          text: "maps",
        ),
      ]),

    );
  }


}
