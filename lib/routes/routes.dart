import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:untitled/features/main/screens/calamity_info.dart';
import 'package:untitled/features/main/screens/main_screen.dart';
import 'package:untitled/features/main/screens/map_screen.dart';

class Routes {
  static const main = "/";
  static const login = "/login";
  static const map = "/map";
  static const calamityinfo = "/calamity";


}

class AppRoutes {
  static List<GetPage> get getPage => [
        GetPage(name: Routes.main, page: () =>  MainScreen()),
        GetPage(name: Routes.login, page: () => Container()),
        GetPage(name: Routes.map, page: () => MapScreen()),
        GetPage(name: Routes.calamityinfo, page:()=> CalamityInfo()),
      ];
}
