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
import 'package:untitled/features/main/controller/user_controller.dart';
import 'package:untitled/res/ProjectImages.dart';
import 'package:untitled/services/location.dart';

import '../../../data/models/User.dart';

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
  final UserController user = Get.find();



  Rx<Completer<GoogleMapController>> controller =
      Completer<GoogleMapController>().obs;

  @override
  void onInit() async {
    super.onInit();
    //UserApi(DioClient(Dio())).loginUser("lava", "123");
    checkPermission();

    icons["police"] = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)), 'assets/police.png');
    icons["health"] = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)), 'assets/Ambulance.png');
    icons["fire"] = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)), 'assets/Firetruck.png');
    icons["me"] = BitmapDescriptor.defaultMarker;

  }

  Future<void> goToLocation(CameraPosition pos) async {
    final GoogleMapController _controller = await controller.value.future;
    if (_controller != null) {
      print("Animating camera to: ${pos.target}");
      _controller.animateCamera(CameraUpdate.newCameraPosition(pos));
    } else {
      print("Controller is null!");
    }

  }

  focusOnLocation(double lat, double long) async {
    final c = await controller.value.future;
    c.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
  }

  createMarkerList(List<User> l){
    final list = <Marker>[];
    for(var it in l){
      list.add(createMarker(it));
    }
  }

  checkServiceEnabled() {
    _locationService.checkService().then((value) {
      serviceEnabled.value = value;
      if (value == true) {
        startListeningLocation(
          (p0) async {
            myMarker.value = createMarker(User(
              name: "Me",
              department: "me",
              lat: p0.latitude,
              long: p0.longitude
            ));
            camera.value = createCamera(p0);
            goToLocation(createCamera(p0));
            user.updateUserLocation(p0, user.user.value!.id!);
          },
        );
      }
    });
  }

  Marker createMarker(User p0) {
    final type = p0.department.toString();
    final name = p0.name.toString();
    final p1 = p0.lat!.toDouble();
    final p2 = p0.long!.toDouble();
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
        markerId: MarkerId(p0.id.toString()),
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

  Column bottomSheet(User p0) {
    ImageProvider image = ProjectImages.police;
    if (p0.department == "ambulance") {
      image = ProjectImages.ambulance;
    } else if (p0.department == "fire") {
      image = ProjectImages.firetruck;
    }
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          child: Image(image: image),
        ),
        Text(
          p0.name!,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          p0.department!,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
