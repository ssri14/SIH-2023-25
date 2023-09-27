import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChipController extends GetxController {
  final Rx<int> _selectedChip = 0.obs;

  get selectedChip => _selectedChip.value;

  set selectedChip(index) => _selectedChip.value = index;
  RxList<bool> boolList = <bool>[false,false,false,false].obs;

  RxSet<String> finalType = RxSet<String>();

  RxList<Map<String,dynamic>>  dummyData = <Map<String,dynamic>>[
    {"news": "A massive earthquake has struck the city.", "type": "Ambulance"},
    {"news": "A wildfire is spreading rapidly in the forest.", "type": "Fire"},
    {"news": "There's a riot happening in the downtown area.", "type": "Police"},
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
    {"news": "A flood has submerged several neighborhoods.", "type": "Ambulance"},
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
  RxList<Map<String,dynamic>>  filterData = <Map<String,dynamic>>[
    {"news": "A massive earthquake has struck the city.", "type": "Ambulance"},
    {"news": "A wildfire is spreading rapidly in the forest.", "type": "Fire"},
    {"news": "There's a riot happening in the downtown area.", "type": "Police"},
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
    {"news": "A flood has submerged several neighborhoods.", "type": "Ambulance"},
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

  void updatefilterlist(){
    filterData.clear();
    for(int i = 0;i<dummyData.length;i++){
      if(finalType.isEmpty){
        filterData.add(dummyData[i]);
      }
     for(var it in finalType){
       if(dummyData[i]['type'].toString().contains(it)){
         filterData.add(dummyData[i]);
         break;
       };
     }
    }

  }
  void addToList(String type) {
    finalType.value.add(type);
  }

  void removeFromList(String type) {
    finalType.value.remove(type);
  }
  //
  // void filtering(List<RadioStation> data) {
  //   if (query.value.isEmpty) {
  //     filteredRadioList.value = data;
  //   } else {
  //     filteredRadioList.value = data
  //         .where((element) => element.radioName
  //         .toString()
  //         .toLowerCase()
  //         .contains(query.value.toLowerCase()))
  //         .toList();
  //   }
  // }
}
