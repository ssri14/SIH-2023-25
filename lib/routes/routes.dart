import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:untitled/features/auth/screens/auth_screen.dart';
import 'package:untitled/features/main/screens/calamity_info.dart';
import 'package:untitled/features/main/screens/main_screen.dart';
import 'package:untitled/features/main/screens/map_screen.dart';
import 'package:untitled/features/main/screens/news_screen.dart';

class Routes {
  static const main = "/";
  static const login = "/login";
  static const map = "/map";
  static const news = "/news";
  static const calamityinfo = "/calamity";
}

class AppRoutes {
  static List<GetPage> get getPage => [
        GetPage(name: Routes.main, page: () => const MainScreen()),
        GetPage(name: Routes.login, page: () => const AuthScreen()),
        GetPage(name: Routes.map, page: () => const MapScreen()),
        GetPage(name: Routes.calamityinfo, page: () => CalamityInfo()),
        GetPage(name: Routes.news, page: () => NewsScreen()),
      ];
}
