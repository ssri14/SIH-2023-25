import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/data/network/api/ChatApi.dart';

import '../../../data/network/dio_client.dart';

class CalamityController extends GetxController {
  Rx<String> chat = "".obs;
  Rx<String> username = "lava".obs;
  Rx<String> time = "17:06".obs;
  Rx<String> nid = "".obs;
  RxBool isloading = false.obs;
  RxBool is_selected = false.obs;

  final ChatApi _chatApi = ChatApi(DioClient(Dio()));
  final RxList<String> chatting = RxList<String>();

  Future<void> fetchNewsData() async {
    isloading.value = true;
    try {
      var id = nid.value;
      final calamityList = await _chatApi.getChatApi(id);
      chatting.assignAll(calamityList);
      debugPrint('chatting ${chatting}');
    } catch (error) {
      // Handle errors here if necessary
      print('Error fetching data: $error');
    }
    isloading.value = false;
  }

  void postnewsdata() async {
    try {
      _chatApi.post(
          username.value, convertToTime(DateTime.now()), chat.value, nid.value);
    } catch (error) {
      // Handle errors here if necessary
      print('Error fetching data: $error');
      isloading.value = false;
    }
  }

  String convertToTime(DateTime d) {
    return "${d.hour} : ${d.minute}";
  }
}
