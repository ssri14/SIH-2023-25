import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:untitled/data/models/service.dart';
import 'package:untitled/data/network/dio_client.dart';
import 'package:untitled/data/network/user_api.dart';
import 'package:untitled/res/ProjectImages.dart';
import 'package:untitled/services/location.dart';

class LocationController extends GetxController {
  final _locationService = LocationService();
  Rx<bool> serviceEnabled = false.obs;
  Rx<bool> permission = false.obs;
  Rxn<CameraPosition> camera = Rxn();
  Rxn<LocationData> location = Rxn();
  StreamSubscription<LocationData>? _locationSub;
  Map<String, BitmapDescriptor?> icons = {};
  Rx<Marker> myMarker =
      const Marker(markerId: MarkerId("me"), position: LatLng(0, 0)).obs;

  RxList<Marker> services = <Marker>[].obs;

  final dummyService = [
    RescueService(
        name: "police",
        type: "police",
        id: "1234",
        phoneNo: "222",
        lat: 23.814,
        lng: 86.44220),
    RescueService(
        name: "police",
        type: "police",
        id: "1234",
        phoneNo: "222",
        lat: 23.814,
        lng: 86.44220),
    RescueService(
        name: "ambulance",
        type: "ambulance",
        id: "1234",
        phoneNo: "222",
        lat: 23.4,
        lng: 86.49),
  ];

  Rx<Completer<GoogleMapController>> controller =
      Completer<GoogleMapController>().obs;

  @override
  void onInit() async {
    super.onInit();
    //UserApi(DioClient(Dio())).loginUser("lava", "123");
    checkPermission();
    final list = <Marker>[];
    icons["police"] = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)), 'assets/police.png');
    icons["ambulance"] = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)), 'assets/Ambulance.png');
    icons["me"] = BitmapDescriptor.defaultMarker;
    for (RescueService it in dummyService) {
      // TODO(change here)
      list.add(createMarker(it));
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
          (p0) async {
            myMarker.value = createMarker(RescueService(
                name: "me",
                type: "me",
                id: "123",
                phoneNo: "3443",
                lat: p0.latitude,
                lng: p0.longitude));
            camera.value = createCamera(p0);
            goToLocation(createCamera(p0));
          },
        );
      }
    });
  }

  Marker createMarker(RescueService p0) {
    final type = p0.type;
    final name = p0.name;
    final p1 = p0.lat;
    final p2 = p0.lng;
    if (icons[type] == null) icons[type] = BitmapDescriptor.defaultMarker;
    return Marker(
        icon: icons[type]!,
        onTap: () {
          Get.bottomSheet(
            Container(
                width: Get.width,
                height: Get.height * 0.3,
                color: Colors.white,
                padding: EdgeInsets.only(top: 30),
                child: bottomSheet(p0)),
          );
        },
        markerId: MarkerId(name),
        position: LatLng(p1, p2));
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

  Column bottomSheet(RescueService p0) {
    ImageProvider image = ProjectImages.police;
    if (p0.type == "ambulance") {
      image = ProjectImages.ambulance;
    } else if (p0.type == "fire") {
      image = ProjectImages.firetruck;
    }
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          child: Image(image: image),
        ),
        Text(
          p0.name,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          p0.type,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
