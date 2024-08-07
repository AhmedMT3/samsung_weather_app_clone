import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';
import 'package:weather_app/view/widgets/drawer/drawer_location_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.controller,
  });
  final WeatherController controller;

  @override
  Widget build(BuildContext context) {
    late final Weather firstWeather;
    late final List<Weather> tempWeathers;
    if (controller.weathers.isNotEmpty) {
      firstWeather = controller.weathers.first;
      tempWeathers = controller.weathers.sublist(1);
    }

    return Drawer(
      width: AppHelpers.screenWidth(context) / 1.2,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: controller.isLoading.value || controller.weathers.isEmpty
              ? Center(
                  child: Lottie.asset("assets/lottie/loading.json"),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        alignment: Alignment.topLeft,
                        iconSize: 30,
                        onPressed: () {
                          Get.back();
                          Get.toNamed(AppRoutes.settings);
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    ),
                    const SizedBox(height: 10),
                    titleRow(context, Icons.star_rounded, "Favourite location"),
                    const SizedBox(height: 10),
                    DrawerLocationWidget(
                      icon: Icons.location_pin,
                      locationName: firstWeather.location!.name!,
                      imageUrl: firstWeather.current!.condition!.icon,
                      temp: firstWeather.current!.tempC!.toInt().toString(),
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.locations);
                      },
                    ),
                    const SizedBox(height: 10),
                    customDivider(context),
                    const SizedBox(height: 17),
                    titleRow(context, Icons.add_location_outlined,
                        "Other locations"),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: tempWeathers.length,
                        itemBuilder: (context, index) => DrawerLocationWidget(
                          locationName: tempWeathers[index].location!.name!,
                          imageUrl:
                              tempWeathers[index].current!.condition!.icon,
                          temp:
                              "${tempWeathers[index].current!.tempC!.toInt()}",
                          onTap: () {
                            controller.onReorder(index + 1, 0);
                            Get.back();
                            Get.toNamed(AppRoutes.home);
                          },
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Get.back();
                        Get.toNamed(AppRoutes.locations);
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color(0xFF474646),
                      elevation: 0,
                      child: const Text(
                        "Manage locations",
                        style: AppStyles.bodyMediumL,
                      ),
                    ),
                    const SizedBox(height: 10),
                    customDivider(context),
                    const Spacer()
                  ],
                ),
        ),
      ),
    );
  }

  Row titleRow(
    BuildContext ctx,
    IconData icon,
    String title,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: Theme.of(ctx).textTheme.titleMedium,
        ),
      ],
    );
  }

  Row customDivider(BuildContext ctx) {
    return Row(
      children: List.generate(
        AppHelpers.screenWidth(ctx) ~/ 4,
        (index) => Expanded(
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.transparent : Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
