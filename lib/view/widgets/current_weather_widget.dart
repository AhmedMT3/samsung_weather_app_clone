// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/forecast.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({
    super.key,
    required this.currentWeather,
    required this.day,
  });

  final CurrentWeather currentWeather;
  final Day day;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${currentWeather.current!.tempC!.toInt().toString()}˚",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(currentWeather.current!.condition!.text!,
                  style: AppStyles.bodyMediumXL),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Icon(Icons.location_pin),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      currentWeather.location!.name!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "${day.maxtempC!.toInt()}˚ / ${day.mintempC!.toInt()}˚ Feels like ${currentWeather.current!.feelslikeC!.toInt()}˚",
              ),
            ],
          ),
        ),
        Image.network(
          "https:${currentWeather.current!.condition!.icon}"
              .replaceAll('64x64', '128x128'),
          scale: 0.7,
        )
      ],
    );
  }
}
