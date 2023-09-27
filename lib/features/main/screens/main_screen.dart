import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:untitled/data/models/User.dart';
import 'package:untitled/features/main/controller/main_controller.dart';
import 'package:untitled/features/main/screens/calamity_info.dart';
import 'package:untitled/features/main/screens/map_screen.dart';
import 'package:untitled/features/main/screens/news_screen.dart';

import '../controller/api_controller.dart';

class MainScreen extends StatelessWidget {
  final apiController = Get.put(ApiController());
  final user = User();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final main = Get.put(MainController());
    final TextEditingController textEditingController = TextEditingController();
    final PageController pageController = PageController(initialPage: 0);

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: Obx(() => FittedBox(
                child: main.page.value == 2
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.red,
                  onPressed: () {
                    textEditingController.clear();
                    Get.bottomSheet(

                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                          child: Column(

                            children: [
                              const Text(
                                'What is your Emergency?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF3D3D3D),
                                  fontSize: 20,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                  letterSpacing: -0.50,
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Add some spacing between text and TextField
                              TextField(
                                controller: textEditingController,
                                maxLines: 4,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Rounded border
                                  ),
                                  hintText: 'Describe about the emergency', // Hint text
                                ),
                              ),
                              SizedBox(height: 16),
                              // Add some spacing between TextField and Chips
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildFilterChipBMS(
                                      'Ambulance', Icons.medical_services, 0, apiController),
                                  buildFilterChipBMS('Fire', Icons.fire_truck, 1, apiController),
                                  buildFilterChipBMS('Police', Icons.shield, 2, apiController),
                                ],
                              ),
                              const SizedBox(height: 16),

                              ElevatedButton(
                                onPressed: () async {
                                  final selectedChips = <String>[];
                                  for (int i = 0; i < apiController.approvalType.length; i++) {
                                    if (apiController.approvalType[i]) {
                                      selectedChips.add(['Ambulance', 'Fire', 'Police'][i]);
                                    }
                                  }
                                  final selectedType = selectedChips.join('/');

                                  final newsText = textEditingController.text.trim();

                                  if (newsText.isEmpty) {
                                    // Display a prompt if the text field is empty
                                    Get.snackbar(
                                      'Fill in the details',
                                      'Please describe your emergency.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 3),
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  } else if (selectedType.isEmpty) {
                                    // Handle the case when type is empty
                                    Get.snackbar(
                                      'Type is required',
                                      'Please select a type for your emergency.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 3),
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  } else {
                                    // Now, send the news with the selected type
                                    await apiController.sendNewsApi(
                                      'dhanbad', // user.district.toString(),
                                      newsText,
                                      selectedType,
                                      DateFormat('HH:mm').format(DateTime.now()),
                                    );

                                    // Dismiss the BottomSheet
                                    Navigator.of(context).pop();
                                    // textEditingController.dispose();
                                    // Show the success Snackbar
                                    Get.snackbar(
                                      'Approval Raised Successfully',
                                      'Your emergency approval has been raised.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                child: const Text('Raise Approval'),
                              ),

                            ],
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 10,

                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "SOS",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),

              )),
        ),
        bottomNavigationBar: Obx(() => GNav(
                onTabChange: (e) {
                  pageController.animateToPage(e,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear);
                },
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    iconSize: main.page.value == 0 ? 25 : 17,
                  ),
                  GButton(
                    icon: Icons.search_outlined,
                    iconSize: main.page.value == 1 ? 25 : 17,
                  ),
                  GButton(
                    icon: Icons.messenger_outline,
                    iconSize: main.page.value == 2 ? 25 : 17,
                  ),
                ])),
        body: PageView(
          controller: pageController,
          onPageChanged: (e) {
            main.page.value = e;
          },
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const MapScreen(),
            const NewsScreen(),
            CalamityInfo(),
          ],
        ));
  }
}

Obx buildFilterChipBMS(
    String text, IconData icon, int index, ApiController apiController) {
  return Obx(() => FilterChip(
        label: Text(text),
        side: BorderSide.none,
        backgroundColor: Colors.transparent,
        selectedColor: Colors.blue,
        avatar: Icon(icon),
        selected: apiController.approvalType[index],
        onSelected: (bool value) {
          apiController.approvalType[index] = value;
        },
        showCheckmark: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
      ));
}
