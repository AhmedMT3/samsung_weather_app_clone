import 'package:get/get.dart';
import 'package:weather_app/view/home_view.dart';
import 'package:weather_app/view/locations_view.dart';
import 'package:weather_app/view/search_view.dart';
import 'package:weather_app/view/settings_view.dart';

class AppRoutes {
  static const String home = '/';
  static const String settings = '/settings';
  static const String locations = '/locations';
  static const String search = '/search';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeView(),
    ),
    GetPage(
      name: locations,
      page: () => const ManageLocationsView(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsView(),
    ),
    GetPage(
      name: search,
      page: () => const SearchView(),
    )
  ];
}
