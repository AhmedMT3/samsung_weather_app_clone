import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/view/widgets/manage_locations/location_widget.dart';

class ManageLocationsView extends StatelessWidget {
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: GetBuilder<WeatherController>(
            builder: (controller) => Column(
              children: [
                Obx(
                  () => controller.weathers.isEmpty
                      ? Lottie.asset("assets/lottie/loading.json")
                      : Expanded(
                          child: ReorderableListView.builder(
                            onReorder: (oldIndex, newIndex) =>
                                controller.onReorder(oldIndex, newIndex),
                            itemCount: controller.weathers.length,
                            itemBuilder: (context, index) => LocationWidget(
                              key: Key(index.toString()),
                              currentWeather:
                                  controller.weathers[index].currentWeather,
                              day: controller.weathers[index].forecastWeather
                                  .forecast!.forecastday!.first.day!,
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
