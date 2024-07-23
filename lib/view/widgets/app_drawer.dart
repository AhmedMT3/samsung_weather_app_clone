import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/themes/app_styles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.controller,
  });
  final WeatherController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: AppStyles.bodyMediumL.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              drawerLocationWidget(
                icon: Icons.location_pin,
                locationName: controller.location,
                isDay: controller.weather!.current!.isDay,
                temp: controller.weather!.current!.tempC!.toInt().toString(),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
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
                    style: AppStyles.bodyMediumXL.copyWith(color: Colors.grey),
                  ),
                ],
              ),
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
  int? isDay,
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
        if (isDay != null)
          isDay == 1
              ? const Icon(Icons.sunny, size: 20)
              : const Icon(Icons.nightlife, size: 20),
        const SizedBox(width: 10),
        Text(temp)
      ],
    ),
  );
}
