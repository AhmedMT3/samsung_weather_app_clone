// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weather_app/core/themes/app_styles.dart';

class PopupSettingsMenuItem extends StatelessWidget {
  const PopupSettingsMenuItem({
    Key? key,
    required this.property,
    required this.value,
    required this.options,
    this.isTop,
    this.isBottm,
  }) : super(key: key);
  final String property;
  final String value;
  final List<PopupMenuEntry<dynamic>> Function(BuildContext) options;
  final bool? isTop;
  final bool? isBottm;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.vertical(
        top: isTop != null ? const Radius.circular(15) : Radius.zero,
        bottom: isBottm != null ? const Radius.circular(15) : Radius.zero,
      ),
      child: PopupMenuButton(
          color: const Color(0xFF373737),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: options,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property,
                  style: AppStyles.bodyMediumXL,
                ),
                Text(
                  value,
                  style: AppStyles.bodyRegularL.copyWith(color: Colors.blue),
                ),
              ],
            ),
          )),
    );
  }
}
