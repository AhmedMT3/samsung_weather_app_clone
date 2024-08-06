// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather_app/core/themes/app_styles.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppStyles.bodyMediumL.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 40)
      ],
    );
  }
}
