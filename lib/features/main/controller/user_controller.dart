import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/data/network/dio_client.dart';
import 'package:untitled/data/network/user_api.dart';
import 'package:untitled/routes/routes.dart';

import '../../../data/models/User.dart';

class UserController extends GetxController {
  final _api = UserApi(DioClient(Dio()));
  Rxn<User> user = Rxn();
  RxList<User> allUsers = <User>[].obs;

  void loginUser(String name, String password) {
    _api.loginUser(name, password).then((value) {
      user.value = value;
      if(value!=null) Get.toNamed(Routes.main);
    });
  }

  void updateUserLocation(LatLng loc, String id) {
    _api.updateLocation(loc, id).then((value) {
      if (value != null) user.value = value;
    });
  }

  void getOtherUsers() {
    if (user.value == null) return;
    final List<User> list = [];
    _api.getOtherUsers(user.value!.adminUsername!).then((value) {
      final res = value.data["allSubordinates"];
      for (var it in res) {
        list.add(User.fromJson(it));
      }
      allUsers.clear();
      allUsers.value = list;
      log("$allUsers", name: "ALL USERS");
      debugPrint("${allUsers[5].department}");
    });
  }
}
