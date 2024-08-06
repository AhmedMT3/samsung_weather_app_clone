import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/view/widgets/manage_locations/location_widget.dart';
import 'package:weather_app/view/widgets/manage_locations/title_row.dart';

class LocationsView extends StatelessWidget {
  const LocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(
      builder: (controller) => Scaffold(
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
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.deleteLocation,
          child: const Icon(Icons.delete),
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
                            header: const TitleRow(
                              title: "Favourite location",
                              icon: Icons.star_rounded,
                            ),
                            itemBuilder: (context, index) => Column(
                              key: Key("$index+Col"),
                              children: [
                                if (index == 1)
                                  GestureDetector(
                                    onLongPress: () {},
                                    child: const TitleRow(
                                        title: "Other locations",
                                        icon: Icons.add_location),
                                  ),
                                LocationWidget(
                                  index: index,
                                  isSelected: controller.selectedLocations
                                      .contains(index),
                                  onLongPress: () =>
                                      controller.onLongPressLocation(index),
                                  onTap: () => controller.onTapLocation(index),
                                  key: Key("$index"),
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
      ),
    );
  }
}
