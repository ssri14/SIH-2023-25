import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:untitled/data/models/calamity_model.dart';
import 'package:untitled/features/main/controller/api_controller.dart';

class ChipController extends GetxController {
  final ApiController apiController = Get.find();
  final Rx<int> _selectedChip = 0.obs;
  Rx<String> query = "".obs;

  RxList<bool> boolList = <bool>[false, false, false].obs;

  RxSet<String> finalType = RxSet<String>();
  RxList<Calamity> filteredNews = RxList<Calamity>([]);
  // RxList<Calamity> finalFilteredNews = RxList<Calamity>([]);

  RxList<Map<String, dynamic>> dummyData = <Map<String, dynamic>>[
    {"news": "A massive earthquake has struck the city.", "type": "Ambulance"},
    {"news": "A wildfire is spreading rapidly in the forest.", "type": "Fire"},
    {
      "news": "There's a riot happening in the downtown area.",
      "type": "Police"
    },
    {
      "news": "A building has collapsed, and people are trapped inside.",
      "type": "Ambulance"
    },
    {
      "news": "A chemical spill has occurred at the industrial site.",
      "type": "Fire"
    },
    {
      "news":
          "A protest has turned violent, and there's a need for law enforcement.",
      "type": "Police"
    },
    {
      "news": "A flood has submerged several neighborhoods.",
      "type": "Ambulance"
    },
    {
      "news": "A major fire has broken out in a residential area.",
      "type": "Fire"
    },
    {"news": "A hostage situation is ongoing at a bank.", "type": "Police"},
    {
      "news":
          "An accident on the highway requires both ambulance and fire assistance.",
      "type": "Ambulance/Fire"
    },
    {
      "news":
          "A massive fire has erupted at an industrial facility, needing fire and police response.",
      "type": "Fire/Police"
    },
    {
      "news": "A severe car crash demands ambulance and police services.",
      "type": "Ambulance/Police"
    },
    {
      "news":
          "A natural disaster has struck, requiring all three types of assistance.",
      "type": "Ambulance/Fire/Police"
    }
  ].obs;

  get selectedChip => _selectedChip.value;

  set selectedChip(index) => _selectedChip.value = index;

  void refreshList() {
    filteredNews.refresh();

    //finalFilteredNews.refresh();
  }

  // void updatefilterlist() {
  //   filteredNews.clear();
  //   for (int i = 0; i < filteredNews.length; i++) {
  //     if (finalType.isEmpty) {
  //       break;
  //       // filteredNews.add(apiController.news.value[i]);
  //     }
  //     for (var it in finalType) {
  //       if (filteredNews.value[i].type.toString().contains(it)) {
  //         filteredNews.add(filteredNews[i]);
  //         break;
  //       }
  //       ;
  //     }
  //   }
  //   refreshList();
  // }

  // void finalFiltering() {
  //
  //   if (finalType.isEmpty) {
  //     finalFilteredNews.value = filteredNews.value;
  //   } else {
  //     finalFilteredNews.clear();
  //     for (var it in filteredNews) {
  //       for (var tit in finalType) {
  //         debugPrint('tit and it $tit and $it');
  //         log('tit and it $tit and $it',name: 'LEN');
  //         if (it.type!.contains(tit.toString())) {
  //
  //           finalFilteredNews.add(it);
  //           break;
  //         }
  //       }
  //     }
  //   }
  //   refreshList();
  // }

  void filtering(List<Calamity> data) {
    if (query.value.isEmpty) {
      filteredNews.value = data;
    } else {
      filteredNews.value = data
          .where((element) => element.news
              .toString()
              .toLowerCase()
              .contains(query.value.toLowerCase()))
          .toList();
    }
    refreshList();
  }

  void addToList(String type) {
    finalType.value.add(type);
    refreshList();
  }

  void removeFromList(String type) {
    finalType.value.remove(type);
    refreshList();
  }
}

// RxList<Map<String,dynamic>>  filterData = <Map<String,dynamic>>[
//   {"news": "A massive earthquake has struck the city.", "type": "Ambulance"},
//   {"news": "A wildfire is spreading rapidly in the forest.", "type": "Fire"},
//   {"news": "There's a riot happening in the downtown area.", "type": "Police"},
//   {
//     "news": "A building has collapsed, and people are trapped inside.",
//     "type": "Ambulance"
//   },
//   {
//     "news": "A chemical spill has occurred at the industrial site.",
//     "type": "Fire"
//   },
//   {
//     "news":
//     "A protest has turned violent, and there's a need for law enforcement.",
//     "type": "Police"
//   },
//   {"news": "A flood has submerged several neighborhoods.", "type": "Ambulance"},
//   {
//     "news": "A major fire has broken out in a residential area.",
//     "type": "Fire"
//   },
//   {"news": "A hostage situation is ongoing at a bank.", "type": "Police"},
//   {
//     "news":
//     "An accident on the highway requires both ambulance and fire assistance.",
//     "type": "Ambulance/Fire"
//   },
//   {
//     "news":
//     "A massive fire has erupted at an industrial facility, needing fire and police response.",
//     "type": "Fire/Police"
//   },
//   {
//     "news": "A severe car crash demands ambulance and police services.",
//     "type": "Ambulance/Police"
//   },
//   {
//     "news":
//     "A natural disaster has struck, requiring all three types of assistance.",
//     "type": "Ambulance/Fire/Police"
//   }
// ].obs;
// RxList<Map<String,dynamic>>  filterData = <Map<String,dynamic>>[
//
// ].obs;
