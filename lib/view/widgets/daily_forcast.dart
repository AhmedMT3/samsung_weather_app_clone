import 'package:flutter/material.dart';

import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';

class DailyForcast extends StatelessWidget {
  const DailyForcast({
    super.key,
    required this.forecastday,
  });
  final List<Forecastday> forecastday;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xC919346B),
          borderRadius: BorderRadius.circular(12)),
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: forecastday.length,
        itemBuilder: (context, index) => Column(
          children: [
            Row(
              children: [
                Text(
                  AppHelpers.getHumanReadableDate(forecastday[index].date!),
                  style: AppStyles.bodyMediumXL,
                ),
                const Spacer(),
                const Icon(
                  Icons.water_drop,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text("${forecastday[index].day!.dailyChanceOfRain}%"),
                const SizedBox(width: 40),
                Text(
                  "${forecastday[index].day!.maxtempC!.toInt()}˚ ${forecastday[index].day!.mintempC!.toInt()}˚",
                  style: AppStyles.bodyMediumXL,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
