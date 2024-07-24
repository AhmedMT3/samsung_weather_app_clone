import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/widgets/daily_forcast.dart';
import 'package:weather_app/view/widgets/outlook_widget.dart';
import 'package:weather_app/view/app_drawer.dart';
import 'package:weather_app/view/widgets/current_weather_widget.dart';
import 'package:weather_app/view/widgets/hourly_forcast.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final WeatherController controller = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Obx(
        () => AppDrawer(
          isLoading: controller.isLoading.value,
          currentWeather: controller.currentWeather,
        ),
      ),
      body: GetBuilder<WeatherController>(
        builder: ((controller) => RefreshIndicator(
              onRefresh: () => controller.refreshWeather(),
              child: SafeArea(
                child: controller.isLoading.value
                    ? Center(child: Lottie.asset("assets/lotties/loading.json"))
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              CurrentWeatherWidget(
                                currentWeather: controller.currentWeather!,
                                day: controller.forecastWeather!.forecast!
                                    .forecastday!.first.day!,
                              ),
                              const SizedBox(height: 30),
                              HourlyForcast(
                                hours: controller.forecastWeather!.forecast!
                                    .forecastday!.first.hour!,
                                day: controller.forecastWeather!.forecast!
                                    .forecastday!.first.day!,
                              ),
                              const SizedBox(height: 10),
                              OutlookWidget(),
                              const SizedBox(height: 10),
                              DailyForcast(),
                            ],
                          ),
                        ),
                      ),
              ),
            )),
      ),
    );
  }
}
