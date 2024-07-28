import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';
import 'package:weather_app/view/widgets/home/daily_forcast.dart';
import 'package:weather_app/view/widgets/home/double_property_widget.dart';
import 'package:weather_app/view/widgets/home/outlook_widget.dart';
import 'package:weather_app/view/app_drawer.dart';
import 'package:weather_app/view/widgets/home/current_weather_widget.dart';
import 'package:weather_app/view/widgets/home/hourly_forcast.dart';
import 'package:weather_app/view/widgets/home/property_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(
      builder: (controller) => Scaffold(
        backgroundColor: controller.backgroundColor,
        appBar: AppBar(),
        drawer: AppDrawer(
          controller: controller,
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.refreshWeather(),
          child: SafeArea(
            child: controller.isLoading.value
                ? Center(child: Lottie.asset("assets/lottie/loading.json"))
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
                          OutlookWidget(
                            controller: controller,
                            astro: controller.forecastWeather!.forecast!
                                .forecastday!.first.astro!,
                          ),
                          const SizedBox(height: 10),
                          DailyForcast(
                            forecastday: controller
                                .forecastWeather!.forecast!.forecastday!,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              PropertyWidget(
                                svg: "uv.svg",
                                name: "UV index",
                                value: AppHelpers.getUVIndexDescription(
                                    controller.currentWeather!.current!.uv!),
                              ),
                              const SizedBox(width: 10),
                              PropertyWidget(
                                svg: "water.svg",
                                name: "Humidity",
                                value:
                                    "${controller.currentWeather!.current!.humidity}%",
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              PropertyWidget(
                                svg: "wind.svg",
                                name: "Wind",
                                value:
                                    " ${controller.currentWeather!.current!.windKph!.toInt()} km/h",
                              ),
                              const SizedBox(width: 10),
                              DoublePropertyWidget(
                                svg1: "sunrise.svg",
                                svg2: "sunset.svg",
                                name1: "Sunrise",
                                name2: "Sunset",
                                value1: controller.forecastWeather!.forecast!
                                    .forecastday!.first.astro!.sunrise!,
                                value2: controller.forecastWeather!.forecast!
                                    .forecastday!.first.astro!.sunset!,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
