import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/widgets/location_widget.dart';

class ManageLocationsView extends StatelessWidget {
  const ManageLocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Locations"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: GetBuilder<WeatherController>(
            builder: (controller) => Column(
              children: [
                SearchBar(
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 15),
                  ),
                  elevation: const WidgetStatePropertyAll(1),
                  hintText: "Search location..",
                  trailing: const [Icon(Icons.search)],
                  onSubmitted: (value) => controller.getWeatherData(value),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Obx(
                    () => controller.isLoading.value == true
                        ? Lottie.asset("assets/lottie/loading.json")
                        : LocationWidget(
                            currentWeather: controller.currentWeather!,
                            day: controller.forecastWeather!.forecast!
                                .forecastday!.first.day!,
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
