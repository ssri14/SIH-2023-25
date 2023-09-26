import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/features/main/controller/location_controller.dart';
import 'package:untitled/features/main/controller/map_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController map = Get.put(MapController());
    final LocationController loc = Get.put(LocationController());
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: const CameraPosition(target: LatLng(0.00, 0.00)),
      onMapCreated: (GoogleMapController controller) {
        loc.controller.value.complete(controller);
      },
      markers: {loc.myMarker.value},
    );
  }
}
