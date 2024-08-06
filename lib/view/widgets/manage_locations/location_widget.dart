// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.weather,
    required this.day,
    required this.index,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
  });
  final Weather weather;
  final Day day;
  final int index;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xFF212121),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ? Colors.blue : const Color(0xFF212121)),
        ),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              ReorderableDragStartListener(
                index: index,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 15,
                        color: Color(0xFFDBDADC),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: -1,
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 15,
                        color: Color(0xFFDBDADC),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.location!.name!,
                      style: AppStyles.bodySemiBoldXL,
                    ),
                    Text(
                      weather.location!.country!,
                      style: AppStyles.bodyRegularS,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${AppHelpers.getHumanReadableDate(weather.location!.localtime!.split(' ').first)}, ${weather.location!.localtime!.split(' ').last}",
                      style: AppStyles.bodyRegularS,
                    )
                  ],
                ),
              ),
              const Spacer(),
              Image.network(
                "https:${weather.current!.condition!.icon}",
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.wifi_off),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    "${weather.current!.tempC!.toInt()}˚",
                    style: AppStyles.bodyRegularXL,
                  ),
                  Text("${day.maxtempC!.toInt()}˚ / ${day.mintempC!.toInt()}˚")
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
