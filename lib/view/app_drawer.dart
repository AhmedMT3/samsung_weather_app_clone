// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/current_weather.dart';
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
    final CurrentWeather firstCurrentWeather =
        controller.weathers.first.currentWeather;
    final RxList<Weather> weathers = controller.weathers;

    return Drawer(
      width: AppHelpers.screenWidth(context) / 1.2,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: controller.isLoading.value
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
                    titleRow(Icons.star_rounded, "Favourite location"),
                    const SizedBox(height: 10),
                    DrawerLocationWidget(
                      icon: Icons.location_pin,
                      locationName: firstCurrentWeather.location!.name!,
                      imageUrl: firstCurrentWeather.current!.condition!.icon,
                      temp: firstCurrentWeather.current!.tempC!
                          .toInt()
                          .toString(),
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.locations);
                      },
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    titleRow(Icons.add_location, "Other locations"),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.weathers.length,
                        itemBuilder: (context, index) => DrawerLocationWidget(
                          locationName:
                              weathers[index].currentWeather.location!.name!,
                          imageUrl: weathers[index]
                              .currentWeather
                              .current!
                              .condition!
                              .icon,
                          temp: weathers[index]
                              .currentWeather
                              .current!
                              .tempC!
                              .toInt()
                              .toString(),
                          onTap: () {
                            Get.back();
                            Get.toNamed(AppRoutes.settings);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Row titleRow(IconData icon, String title) {
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
          style: AppStyles.bodyMediumL.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
