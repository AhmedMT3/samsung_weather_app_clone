// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.isLoading,
    required this.currentWeather,
  });
  final bool isLoading;
  final CurrentWeather? currentWeather;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: AppHelpers.screenWidth(context) / 1.2,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: isLoading
              ? Center(
                  child: Lottie.asset("assets/lottie/loading.json"),
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
                      onPressed: () {
                        Get.back();
                        Get.toNamed('/manage_loc');
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
        if (icon != null) ...[
          Icon(icon),
        ],
        const SizedBox(width: 10),
        Expanded(
          flex: 4,
          child: Text(
            locationName,
            style: AppStyles.bodyMediumXL,
            overflow: TextOverflow.visible,
          ),
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
