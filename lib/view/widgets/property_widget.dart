// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:weather_app/core/themes/app_styles.dart';

class PropertyWidget extends StatelessWidget {
  const PropertyWidget({
    super.key,
    required this.svg,
    required this.name,
    required this.value,
  });
  final String svg;
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            color: const Color(0xC919346B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(children: [
              SvgPicture.asset(
                'assets/svg/$svg',
                width: 40,
                height: 40,
                allowDrawingOutsideViewBox: true,
              ),
              Text(
                name,
                style: AppStyles.bodyBoldM,
              ),
              Text(
                value,
                style: const TextStyle(color: Color(0xFFBCBCBC)),
              ),
            ]),
          )),
    );
  }
}
