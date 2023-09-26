import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  Rxn<GoogleMap> map = Rxn();
  Rxn<CameraPosition> camera = Rxn();

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();



  Future<void> goToLocation(CameraPosition pos) async {
    final GoogleMapController _controller = await controller.future;
    await _controller.animateCamera(CameraUpdate.newCameraPosition(pos));
  }




}
