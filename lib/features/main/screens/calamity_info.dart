import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled/data/models/calamity_model.dart';
import 'package:untitled/dummy/dummy.dart';
import 'package:untitled/features/main/controller/calamity_controller.dart';
import 'package:untitled/features/main/controller/user_controller.dart';

class CalamityInfo extends StatelessWidget {
  CalamityInfo({Key? key}) : super(key: key);
  final height = Get.height;
  final width = Get.width;
  final calamity = Get.arguments as Calamity;

  final CalamityController myController = Get.put(CalamityController());
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    myController.fetchNewsData();
    myController.nid.value = calamity.sId!;
    const threeSeconds = Duration(seconds: 10);
    Timer.periodic(threeSeconds, (Timer t) => myController.fetchNewsData());
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: height,
        width: width,
        color: const Color(0xffF1F2F5),
        child: Column(
          children: [
            Container(
              width: width,
              color: const Color(0xffF1F2F5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, bottom: 28, left: 20),
                    child: CircleAvatar(
                      radius: height * 0.05,
                      backgroundImage: AssetImage(getImageForCalamityType(
                          calamity.type!, calamityImage)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          calamity.type!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              calamity.location!,
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                // Color of the underline (optional)
                                decorationThickness: 2.0,
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "NEWS:",
                              style: (TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              calamity.news!,
                              style: (const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17)),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Color(0xff3C3C43),
              thickness: 0.5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Obx(() => create()),
              ),
            ),
            Container(
              width: width,
              height: 100,
              // Total height of the input area including the grey background
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.9,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffF2F2F2)),
                    height: 50, // Height of the grey background

                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none, // Remove border
                              ),
                              onChanged: (String s) {
                                myController.chat.value = s;
                              },
                            ),
                          ),
                          Obx(() => Button())
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget Button() {
    if (myController.chat.isEmpty) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    } else {
      return IconButton(
          onPressed: () {
            myController.username.value = userController.user.value!.username!;
            myController.postnewsdata();


          },
          icon: const Icon(Icons.send));
    }
  }

  Widget create() {
    if (myController.chatting.isNotEmpty) {
      return ListView.builder(
          itemCount: myController.chatting.length,
          itemBuilder: (BuildContext context, int index) {
            String input = myController.chatting[index];
            List<String> output = input.split(RegExp(r"[%|]"));
            return createContainer(output[1], output[0], output[2]);
          });
    } else {
      return Shimmer.fromColors(
          period: const Duration(seconds: 2),
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[200]!,
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return createContainer("Kaushan", "Ambulance bhejo", "Time");
              }));
    }
  }

  Widget createContainer(String name, String chat, String time) {
    return Card(
      elevation: 4.0,
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
          contentPadding: const EdgeInsets.all(16.0),
          leading: const Icon(
            CupertinoIcons.profile_circled,
            size: 45,
            color: Colors.black,
          ),
          trailing: Text(time),
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.05,
            ),
          ),
          subtitle: Text(
            chat,
            style: TextStyle(
              color: const Color(0xff5D6066),
              fontSize: width * 0.035,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          tileColor: Colors.white,
          onTap: () {
            // Add any onTap functionality here
          },
        ),
      ),
    );
  }

  // Widget createContainer(String name, String chat) {
  //   return Container(
  //     width: width * 0.9,
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //       color: Colors.white,
  //     ),
  //     height: 100.0,
  //     margin: const EdgeInsets.all(16.0),
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       children: [
  //         const Image(
  //           image: ProjectImages.ambulance,
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 20, top: 10),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 name,
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: width * 0.05),
  //               ),
  //               const SizedBox(
  //                 height: 5,
  //               ),
  //               Text(
  //                 chat,
  //                 style: TextStyle(
  //                     color: const Color(0xff5D6066), fontSize: width * 0.04),
  //               )
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Color givecolor() {
    if (myController.is_selected.value) {
      return Colors.blue;
    } else {
      return Colors.white;
    }
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
}
