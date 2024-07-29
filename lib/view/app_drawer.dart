// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/current_weather.dart';
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
    final CurrentWeather? currentWeather = controller.currentWeather;

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
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 25,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Favourite location",
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DrawerLocationWidget(
                      icon: Icons.location_pin,
                      locationName: currentWeather!.location!.name!,
                      imageUrl: currentWeather.current!.condition!.icon,
                      temp: currentWeather.current!.tempC!.toInt().toString(),
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.locations);
                      },
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.add_location_alt_rounded,
                          size: 25,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Other locations",
                          style: AppStyles.bodyMediumXL
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DrawerLocationWidget(
                      locationName: currentWeather.location!.name!,
                      imageUrl: currentWeather.current!.condition!.icon,
                      temp: currentWeather.current!.tempC!.toInt().toString(),
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
}
