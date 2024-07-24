// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/current_weather.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.currentWeather,
  });
  final CurrentWeather currentWeather;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xC919346B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Column(
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
            SizedBox(height: 10),
            Text(
              currentWeather.location!.localtime!,
              style: AppStyles.bodyRegularS,
            )
          ],
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
            Text("12˚ / 33˚")
          ],
        )
      ]),
    );
  }
}
