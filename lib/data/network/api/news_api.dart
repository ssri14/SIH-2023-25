import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/data/models/calamity_model.dart';
import 'package:untitled/data/network/dio_client.dart';

import 'constant/endpoints.dart';

class NewsApi {
  final DioClient dioClient;

  NewsApi(this.dioClient);

  Future<List<Calamity>> getNewsApi(String district) async {
    district = 'dhanbad';
    var response = await dioClient.get(
      '${Endpoints.baseUrl}${Endpoints.news}/$district',
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      final newsData = response.data['news'];

      // Ensure that newsData is a List<dynamic> before trying to map it
      if (newsData is List<dynamic>) {
        return List<Calamity>.from(newsData.map((e) => Calamity.fromJson(e)));
      } else {
        // Handle the case where 'newsData' is not a List<dynamic>
        print('Invalid data format: $newsData');
        return [];
      }
    } else {
      print(response.statusMessage);
      return [];
    }
  }
}
