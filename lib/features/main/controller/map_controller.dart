import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  Rxn<GoogleMap> map = Rxn();
  Rxn<CameraPosition> camera = Rxn();
  RxList<bool> filter = [false, false, false].obs;
  RxSet<String> selected = RxSet();

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  addItem(int i, String name) {
    filter[i] = true;
    selected.add(name);
  }

  removeItem(int i, String name) {
    filter[i] = false;
    selected.remove(name);
  }

  Future<void> goToLocation(CameraPosition pos) async {
    final GoogleMapController _controller = await controller.future;
    await _controller.animateCamera(CameraUpdate.newCameraPosition(pos));
  }
}
