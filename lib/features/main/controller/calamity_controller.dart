import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/data/network/api/ChatApi.dart';

import '../../../data/network/dio_client.dart';

class CalamityController extends GetxController{
Rx<String> chat = "".obs;
Rx<String> username = "lava".obs;
Rx<String> time = "17:06".obs;
RxBool isloading = false.obs;
RxBool is_selected = false.obs;
final ChatApi _chatApi = ChatApi(DioClient(Dio()));
final RxList<String> chatting = RxList<String>();

Future<void> fetchNewsData() async {
  try {
    isloading.value = true;
    var id = '651409e984588edd6b1f7bb7';
    final calamityList = await _chatApi.getChatApi(id);
    chatting.assignAll(calamityList);
    isloading.value = false;
    debugPrint('chatting ${chatting}');

  }
  catch (error) {
    // Handle errors here if necessary
    print('Error fetching data: $error');
    isloading.value = false;
  }
}
void postnewsdata() async {
  try {
 _chatApi.post(username.value,time.value,chat.value, '651409e984588edd6b1f7bb7');
  }
  catch (error) {
    // Handle errors here if necessary
    print('Error fetching data: $error');
    isloading.value = false;
  }
}



}