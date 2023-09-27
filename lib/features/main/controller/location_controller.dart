import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:untitled/data/models/service.dart';
import 'package:untitled/services/location.dart';

class LocationController extends GetxController {
  final _locationService = LocationService();
  Rx<bool> serviceEnabled = false.obs;
  Rx<bool> permission = false.obs;
  Rxn<LocationData> location = Rxn();
  StreamSubscription<LocationData>? _locationSub;
  Rx<Marker> myMarker =
      const Marker(markerId: MarkerId("me"), position: LatLng(0, 0)).obs;

  RxList<Marker> services = <Marker>[].obs;

  final dummyService = [
    RescueService(name: "1", id : "1234" , phoneNo: "222" ,lat: 23.2 ,lng: 86.44),
    RescueService(name: "2", id : "1234" , phoneNo: "222" ,lat: 23.4 ,lng: 86.41),
    RescueService(name: "3", id : "1234" , phoneNo: "222" ,lat: 23.4 ,lng: 86.49),
  ];

  Rx<Completer<GoogleMapController>> controller =
      Completer<GoogleMapController>().obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    final list = <Marker>[];
    for (RescueService it in dummyService) {
      list.add(createMarker(LatLng(it.lat, it.lng), it.name));
    }
    services.value = list;
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
            myMarker.value = createMarker(p0, 'me');
            goToLocation(createCamera(p0));

          },
        );
      }
    });
  }

  Marker createMarker(LatLng p0, String name) {
    return Marker(
        markerId: MarkerId(name), position: LatLng(p0.latitude, p0.longitude));
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
      zoom: 6);

  @override
  void onClose() {
    _locationSub?.cancel();
    super.onClose();
  }
}
