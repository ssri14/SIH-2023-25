import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:untitled/dummy/dummy.dart';
import 'package:untitled/features/main/controller/api_controller.dart';
import 'package:untitled/features/main/controller/user_controller.dart';

import '../../../routes/routes.dart';
import '../controller/chip_controller.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ApiController apiController = Get.find();
  final ChipController chipController = Get.put(ChipController());
  final UserController user = Get.find();
  bool _showClearButton = false;
  late var newsData;
  List<String> listData = List.generate(10, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    newsData = apiController.news;
    chipController.filteredNews.value = newsData;
    // chipController.filteredNews.value =chipController.filteredNews;
    debugPrint('Final filtered list ${chipController.filteredNews}');
    log("$newsData",name:"NEWS");
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 7),
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
                child: TextFormField(
                  controller: _searchController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    chipController.query.value = value;
                    chipController.filtering(newsData);
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Wrap(
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
                                  chipController.boolList[index] = selected;
                                  final category = filter['category'];
                                  if (selected) {
                                    chipController.addToList(category);
                                    debugPrint(
                                        'final list ${chipController.finalType}');
                                  } else {
                                    chipController.removeFromList(category);
                                    debugPrint(
                                        'final list ${chipController.finalType}');
                                  }
                                },
                              ));
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Obx(
              () {
               if (apiController.isLoading.value) {
                 return Shimmer.fromColors(
                    period: const Duration(seconds: 2),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[200]!,
                    child:  ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
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
                              child: const ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                              ),
                            ),
                          );
                        })
                );
               } else {
                 return RefreshIndicator(
                   onRefresh: () async {
                     await apiController.fetchNewsData(user.user.value!.district!);
                   },
                   child: ListView.builder(
                    itemCount: chipController.filteredNews.length,
                    itemBuilder: (BuildContext context, int index) {
                      final calamity = chipController.filteredNews[index];
                      if(calamity.isApproved=="False") return SizedBox(height: 0,);
                      if (calamity.news!.contains(chipController.query.value) &&
                          calamity.type!
                              .contains(chipController.finalType.join("/"))) {
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
                                      calamity.type!, calamityImage),
                                ),
                              ),
                              title: Text(
                                calamity.news!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                calamity.type!,
                                style: const TextStyle(fontSize: 13),
                              ),
                              trailing: Text(
                                calamity.time!,
                                // DateFormat('HH:mm').format(DateTime.now()),
                                style: const TextStyle(
                                    fontSize:
                                        12), // You can adjust the font size
                              ),
                              onTap: ()=>Get.toNamed(Routes.calamityinfo, arguments: calamity),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(
                          height: 0,
                        );
                      }
                    },
                ),
                 );
               }
              },
            )),
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
    chipController.finalType; // Sort the selected types for consistency
    return chipController.finalType.join('/');
  }
}
