import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:untitled/features/main/controller/location_controller.dart';
import 'package:untitled/features/main/controller/map_controller.dart';
import 'package:untitled/features/main/controller/user_controller.dart';

import '../../../data/models/User.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController loc = Get.put(LocationController());
    final MapController map = Get.put(MapController());
    final UserController user = Get.find();
    user.getOtherUsers();
    // loc.goToLocation(loc.createCamera(fromLocation(loc.location.value!)));

    return Stack(
      children: [
        Obx(() {
          var st = <Marker>{};

          for(var it in user.allUsers){
            if( map.selected.isEmpty ||map.selected.contains(it.department)) {
              st.add(loc.createMarker(it));
            }
          }
          st.add(loc.myMarker.value);

          return GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            initialCameraPosition: camera(map),
            onMapCreated: (GoogleMapController controller) {
              loc.controller.value.complete(controller);
            },
            markers: st,
          );
        }),
        Positioned(
          top: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildFilterChip("police", Icons.local_police_outlined, 0, map),
              const SizedBox(
                width: 3,
              ),
              buildFilterChip(
                  "ambulance", Icons.medical_services_outlined, 1, map),
              const SizedBox(
                width: 3,
              ),
              buildFilterChip(
                  "Fire Dept.", Icons.fire_extinguisher_outlined, 2, map),
            ],
          ),
        ),
        Positioned(
            top: 120,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                loc.goToLocation(
                    CameraPosition(target: fromLocation(loc.location.value!)));
              },
              child: const Icon(Icons.gps_fixed_rounded),
            )),
      ],
    );
  }

  Obx buildFilterChip(
      String text, IconData icon, int index, MapController map) {
    return Obx(() => FilterChip(
          label: Text(text),
          side: const BorderSide(width: 0.5),
          backgroundColor: Colors.transparent,
          avatar: Icon(icon),
          selected: map.filter[index],
          showCheckmark: false,
          onSelected: (e) {
            map.filter[index] = e;
            if (map.filter[index] == true) {
              map.selected.add(text);
            } else {
              map.selected.remove(text);
            }
            log("${map.filter}");
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
        ));
  }

  LatLng fromLocation(LocationData data) {
    return LatLng(data.latitude!, data.longitude!);
  }

  camera(MapController map) {
    if (map.camera.value != null) return map.camera.value;
    return const CameraPosition(target: LatLng(0.00, 0.00));
  }
}
