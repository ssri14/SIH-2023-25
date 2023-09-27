import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:untitled/data/models/calamity_model.dart';
import 'package:untitled/data/models/information.dart';
import 'package:untitled/data/network/dio_client.dart';
import 'package:untitled/dummy/dummy.dart';

import 'constant/endpoints.dart';

class ChatApi {
final DioClient dioClient;

  ChatApi(this.dioClient);

Future<List<String>> getChatApi(String id) async {

   debugPrint('${Endpoints.basechaturl}/get/$id');
    var response = await dioClient.get(
      '${Endpoints.basechaturl}/get/$id',

    );

    if (response.statusCode == 200) {

      final chatData = response.data['chat']['messages'];
      print(chatData);
      List<String> err = [];
      for(var it in chatData){
        err.add(it.toString());
      }
      // Ensure that newsData is a List<dynamic> before trying to map it
     return err;
    } else {
      print(response.statusMessage);
      return [];
    }
  }
  Future<void> post(String sender,String time,String message,String nid ) async {
    final body = {"time": time, "message": message,"sender":sender};
    try{
      final response = await dioClient.post('${Endpoints.basechaturl}/post/$nid', data: body);
      print(response.data);
    }catch (e) {
      print('An error occurred: $e');
    }

  }



}
