import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/view/widgets/app_drawer.dart';
import 'package:weather_app/view/widgets/current_weather_widget.dart';
import 'package:weather_app/view/widgets/daily_forcast.dart';
import 'package:weather_app/view/widgets/hourly_forcast.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final WeatherController controller = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(controller: controller),
      body: GetBuilder<WeatherController>(
          builder: ((controller) => RefreshIndicator(
                onRefresh: () => controller.getCurrentWeather('Cairo'),
                child: SafeArea(
                  child: controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                controller.weather == null
                                    ? const Text("No weather Data")
                                    : CurrentWeatherWidget(
                                        weather: controller.weather!),
                                const SizedBox(height: 30),
                                Container(
                                  padding: const EdgeInsets.all(13),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xC919346B),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "A few clouds. Low 27C.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        thickness: 0.2,
                                        color: Color(0xFF9495B8),
                                      ),
                                      HourlyForcast(),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(13),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xC919346B),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Column(
                                    children: [
                                      Text("Don't miss the sunset",
                                          style: AppStyles.bodyMediumXL),
                                      Text("Sunset will be at 7:54")
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                DailyForcast(),
                              ],
                            ),
                          ),
                        ),
                ),
              ))),
    );
  }
}
