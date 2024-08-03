import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/view/widgets/manage_locations/location_widget.dart';

class ManageLocationsView extends GetView<WeatherController> {
  const ManageLocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Locations"),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.search),
            icon: const Icon(
              Icons.add_outlined,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Obx(
                () => controller.weathers.isEmpty
                    ? Lottie.asset("assets/lottie/loading.json")
                    : Expanded(
                        child: ReorderableListView.builder(
                          onReorder: (oldIndex, newIndex) =>
                              controller.onReorder(oldIndex, newIndex),
                          itemCount: controller.weathers.length,
                          header: titleRow(
                            null,
                            Icons.star_rounded,
                            "Favourite location",
                          ),
                          itemBuilder: (context, index) => Column(
                            key: Key("$index+Col"),
                            children: [
                              if (index == 1)
                                GestureDetector(
                                  onHorizontalDragUpdate: (details) =>
                                      log("${details.globalPosition}"),
                                  onLongPress: () {},
                                  child: titleRow(
                                    ValueKey("$index+title"),
                                    Icons.add_location,
                                    "Other locations",
                                  ),
                                ),
                              LocationWidget(
                                key: Key(index.toString()),
                                weather: controller.weathers[index],
                                day: controller.weathers[index].forecast!
                                    .forecastday!.first.day!,
                              ),
                              SizedBox(
                                key: Key("$index+SizedBox"),
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  titleRow(Key? key, IconData icon, String title) {
    return Row(
      key: key,
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
        const SizedBox(height: 40)
      ],
    );
  }
}
