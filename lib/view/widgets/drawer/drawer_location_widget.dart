import 'package:flutter/material.dart';
import 'package:weather_app/core/themes/app_styles.dart';

class DrawerLocationWidget extends StatelessWidget {
  const DrawerLocationWidget({
    super.key,
    required this.locationName,
    required this.temp,
    this.imageUrl,
    this.icon,
  });

  final IconData? icon;
  final String locationName;
  final String? imageUrl;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon),
              ],
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Text(
                  locationName,
                  style: AppStyles.bodyMediumXL,
                  overflow: TextOverflow.visible,
                ),
              ),
              const Spacer(),
              if (imageUrl != null)
                Image.network(
                  "https:$imageUrl",
                  scale: 2,
                ),
              const SizedBox(width: 10),
              Text(temp)
            ],
          ),
        ),
      ),
    );
  }
}