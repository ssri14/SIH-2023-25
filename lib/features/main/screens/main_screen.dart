import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:untitled/features/main/controller/main_controller.dart';
import 'package:untitled/features/main/screens/calamity_info.dart';
import 'package:untitled/features/main/screens/map_screen.dart';
import 'package:untitled/features/main/screens/news_screen.dart';

import '../controller/api_controller.dart';

class MainScreen extends StatelessWidget {

  final apiController = Get.put(ApiController());
  

  
   MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final main = Get.put(MainController());

    final PageController pageController = PageController(initialPage: 0);

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: Obx(() => FittedBox(
                child: main.page.value == 2
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : FloatingActionButton(
                        shape: CircleBorder(),
                        backgroundColor: Colors.red,
                        onPressed: () {},
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
                    iconSize: main.page.value==0?25:17,
                  ),
                  GButton(
                    icon: Icons.search_outlined,
                    iconSize: main.page.value==1?25:17,
                  ),
                  GButton(
                    icon: Icons.messenger_outline,
                    iconSize: main.page.value==2?25:17,
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
            NewsScreen(),
            CalamityInfo(),
          ],
        ));
  }
}
