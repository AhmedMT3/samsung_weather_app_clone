import 'package:flutter/widgets.dart';

import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.currentWeather,
    required this.day,
  });
  final CurrentWeather currentWeather;
  final Day day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xC919346B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentWeather.location!.name!,
                style: AppStyles.bodySemiBoldXL,
              ),
              Text(
                currentWeather.location!.country!,
                style: AppStyles.bodyRegularS,
              ),
              const SizedBox(height: 10),
              Text(
                "${AppHelpers.getHumanReadableDate(currentWeather.location!.localtime!.split(' ').first)}, ${currentWeather.location!.localtime!.split(' ').last}",
                style: AppStyles.bodyRegularS,
              )
            ],
          ),
        ),
        const Spacer(),
        Image.network("https:${currentWeather.current!.condition!.icon}"),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              "${currentWeather.current!.tempC!.toInt()}˚",
              style: AppStyles.bodyRegularXL,
            ),
            Text("${day.maxtempC!.toInt()}˚ / ${day.mintempC!.toInt()}˚")
          ],
        )
      ]),
    );
  }
}
