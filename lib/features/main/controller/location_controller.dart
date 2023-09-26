import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:untitled/services/location.dart';

class LocationController extends GetxController {
  final _locationService = LocationService();
  Rx<bool> serviceEnabled = false.obs;
  Rx<bool> permission = false.obs;
  Rxn<LocationData> location = Rxn();
  StreamSubscription<LocationData>? _locationSub;
  Rx<Marker> myMarker =
      const Marker(markerId: MarkerId("me"), position: LatLng(0, 0)).obs;

  Rx<Completer<GoogleMapController>> controller =
      Completer<GoogleMapController>().obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  Future<void> goToLocation(CameraPosition pos) async {
    final GoogleMapController _controller = await controller.value.future;
    await _controller.animateCamera(CameraUpdate.newCameraPosition(pos));
  }

  checkServiceEnabled() {
    _locationService.checkService().then((value) {
      serviceEnabled.value = value;
      if (value == true) {
        startListeningLocation(
          (p0) {
            myMarker.value = createMarker(p0);
            goToLocation(createCamera(p0));
          },
        );
      }
    });
  }

  Marker createMarker(LatLng p0) {
    return Marker(
        markerId: const MarkerId("me"),
        position: LatLng(p0.latitude, p0.longitude));
  }

  checkPermission() {
    _locationService.checkPermission().then((value) {
      permission.value = value;
      if (value == true) checkServiceEnabled();
    });
  }

  startListeningLocation(void Function(LatLng) onLocationChanged) {
    _locationSub = _locationService.liveLocation.listen((event) {
      location.value = event;
      log("$event", name: "LOCATION");
      onLocationChanged(LatLng(event.latitude!, event.longitude!));
    });
  }

  createCamera(LatLng loc) => CameraPosition(
      bearing: 0.0,
      target: LatLng(loc.latitude, loc.longitude),
      tilt: 0.005,
      zoom: 16);

  @override
  void onClose() {
    _locationSub?.cancel();
    super.onClose();
  }
}
