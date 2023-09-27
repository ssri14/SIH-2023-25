import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/dummy/dummy.dart';

import '../controller/chip_controller.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ChipController chipController = Get.put(ChipController());
  bool _showClearButton = false;
  List<String> listData = List.generate(10, (index) => 'Item ${index + 1}');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 7),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _showClearButton = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          // Remove the border
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _showClearButton
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _showClearButton = false;
                                    });
                                  },
                                )
                              : const SizedBox(),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle filter button tap
                    },
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child:Wrap(
                        spacing: 20,
                        children: List<Widget>.generate(filterChoices.length,
                                (int index) {
                              final filter = filterChoices[index];
                              return Obx(() => ChoiceChip(

                                selectedColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 2,
                                shadowColor: Colors.grey,
                                showCheckmark: false,
                                side: BorderSide.none,
                                avatar: Icon(filter['icon']),
                                label: Text(filter['label'].toString()),
                                // Use filter['label'] to access the label
                                selected: chipController.boolList[index],
                                selectedShadowColor: Colors.blue,

                                onSelected: (bool selected) {

                                  if(index==0){
                                    if(selected){
                                      chipController.boolList.value = [true,true,true,true];
                                    }
                                    else{
                                      chipController.boolList.value = [false,false,false,false];
                                    }
                                    }


                                  chipController.boolList[index] = selected;
                                  final category = filter['category'];
                                  if (selected) {


                                    chipController.addToList(category);
                                    debugPrint('final list ${chipController.finalType.value}');
                                  } else {
                                    chipController.removeFromList(category);
                                    debugPrint('final list ${chipController.finalType.value}');
                                  }
                                  chipController.updatefilterlist();

                                },
                              ));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: chipController.filterData.value.length,
                itemBuilder: (BuildContext context, int index) {
                  final calamity = chipController.filterData.value[index];
                  return Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            getImageForCalamityType(
                                calamity['type']!, calamityImage),
                          ),
                        ),
                        title: Text(
                          calamity['news']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          calamity['type']!,
                          style: const TextStyle(fontSize: 13),
                        ),
                        trailing: Text(
                          DateFormat('HH:mm').format(DateTime.now()),
                          style: const TextStyle(
                              fontSize: 12), // You can adjust the font size
                        ),
                      ),
                    ),
                  );
                },
              ),)
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String getImageForCalamityType(
      String calamityType, List<Map<String, String>> calamityImage) {
    for (var entry in calamityImage) {
      if (entry.containsKey(calamityType)) {
        return entry[calamityType]!;
      }
    }
    // Default image URL if not found
    return 'assets/all.png';
  }

  String generateCalamityTypeString() {
    final calamityTypes = chipController.finalType.toList();
    calamityTypes.sort(); // Sort the selected types for consistency
    return calamityTypes.join('/');
  }
}
