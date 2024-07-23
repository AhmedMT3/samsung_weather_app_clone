import 'package:flutter/material.dart';
import 'package:weather_app/core/themes/app_styles.dart';

class DailyForcast extends StatelessWidget {
  DailyForcast({super.key});
  final List<String> days = [
    'Yesterday',
    'Today',
    'Monday',
    'Tuesday',
    'Wednsday',
    'Thursday',
    'Friday'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xC919346B),
          borderRadius: BorderRadius.circular(12)),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: days.length,
        itemBuilder: (context, index) => Column(
          children: [
            Row(
              children: [
                Text(
                  days[index],
                  style: AppStyles.bodyMediumXL,
                ),
                const Spacer(),
                const Icon(
                  Icons.water_drop,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text("3%"),
                const SizedBox(width: 40),
                Text(
                  "40˚ 27˚",
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
