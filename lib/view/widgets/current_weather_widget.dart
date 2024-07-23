// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/themes/app_styles.dart';

import 'package:weather_app/model/current_weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({
    super.key,
    required this.weather,
  });

  final CurrentWeather weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${weather.current!.tempC!.toInt().toString()}˚",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(weather.current!.condition!.text!,
                style: AppStyles.bodyMediumXL),
            const SizedBox(height: 30),
            Row(
              children: [
                const Icon(Icons.location_pin),
                const SizedBox(width: 5),
                Text(
                  weather.location!.name!,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
                "40˚ / 27˚ Feels like ${weather.current!.feelslikeC!.toInt().toString()}˚"),
          ],
        ),
        Image.network(
          "https:${weather.current!.condition!.icon}"
              .replaceAll('64x64', '128x128'),
          scale: 0.7,
        )
      ],
    );
  }
}
