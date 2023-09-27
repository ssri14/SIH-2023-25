import 'dart:developer';

import 'package:dio/src/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/data/network/api/constant/endpoints.dart';

import '../models/User.dart';
import 'dio_client.dart';

class UserApi {
  final DioClient dio;

  UserApi(this.dio);

  Future<User?> loginUser(String name, String password) async {
    final body = {"username": name, "password": password};
    try {
      log(Endpoints.baseUrl + Endpoints.login);
      final res =
          await dio.post(Endpoints.baseUrl + Endpoints.login, data: body);
      log("$res", name: "RES1");
      return User.fromJson(res.data["existingUser"]);
    } catch (e) {
      log(e.toString(), name: "API FAIL");
      return null;
    }
  }

  Future<User?> updateLocation(LatLng loc, String id) async {
    final body = {"Lat": loc.latitude, "Long": loc.longitude};
    final url = '${Endpoints.baseUrl}${Endpoints.updateLocation}$id/';
    try {
      final res = await dio.post(url, data: body);
      log("$res", name: "RES LOC UPDATE");
      return User.fromJson(res.data["user"]);
    } catch (e) {
      return null;
    }
  }

  Future<Response> getOtherUsers(String adminName) async {
    final url = '${Endpoints.baseUrl}${Endpoints.getSubordinates}/$adminName/';
    return await dio.get(url);
  }
}
