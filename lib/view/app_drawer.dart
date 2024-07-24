import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/current_weather.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.controller,
    this.currentWeather,
  });
  final WeatherController controller;
  final CurrentWeather? currentWeather;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: currentWeather == null
              ? Center(
                  child: Lottie.asset("assets/lotties/loading.json"),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    drawerLocationWidget(
                      icon: Icons.location_pin,
                      locationName: currentWeather!.location!.name!,
                      imageUrl: currentWeather!.current!.condition!.icon,
                      temp: currentWeather!.current!.tempC!.toInt().toString(),
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
                    drawerLocationWidget(
                      locationName: currentWeather!.location!.name!,
                      imageUrl: currentWeather!.current!.condition!.icon,
                      temp: currentWeather!.current!.tempC!.toInt().toString(),
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      onPressed: () => Get.toNamed('/manage_loc'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
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

Container drawerLocationWidget({
  IconData? icon,
  required String locationName,
  String? imageUrl,
  required String temp,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(
          locationName,
          style: AppStyles.bodyMediumXL,
        ),
        const Spacer(),
        if (imageUrl != null)
          Image.network(
            "https:$imageUrl",
            scale: 2,
          ),
        const SizedBox(width: 10),
        Text(temp)
      ],
    ),
  );
}
