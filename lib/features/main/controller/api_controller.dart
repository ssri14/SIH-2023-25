import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/models/calamity_model.dart';
import '../../../data/network/api/news_api.dart';
import '../../../data/network/dio_client.dart'; // Import your NewsApi class

class ApiController extends GetxController {
  final NewsApi _newsApi = NewsApi(DioClient(Dio()));
  final Rx<bool> isLoading = false.obs;
  RxList<Calamity> news = RxList<Calamity>();

  @override
  void onInit() {
    super.onInit();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    try {
      isLoading.value = true;
      // Replace 'your_district' with the actual district you want to fetch news for
      var district = 'dhanbad';
      final calamityList = await _newsApi.getNewsApi(district);
      news.assignAll(calamityList);
      isLoading.value = false;
    }
    catch (error) {
      // Handle errors here if necessary
      print('Error fetching data: $error');
    }
  }
}
