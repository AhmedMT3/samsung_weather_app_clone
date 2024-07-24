import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/core/themes/app_styles.dart';

class OutlookWidget extends StatelessWidget {
  const OutlookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xC919346B),
          borderRadius: BorderRadius.circular(12)),
      child: const Column(
        children: [
          Text("Don't miss the sunset", style: AppStyles.bodyMediumXL),
          Text("Sunset will be at 7:54")
        ],
      ),
    );
  }
}
