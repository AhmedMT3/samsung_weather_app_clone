// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/search_location.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
    required this.controller,
    required this.searchedLocations,
  });
  final WeatherController controller;
  final RxList<SearchLocation> searchedLocations;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF212121),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: searchedLocations.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () =>
              controller.selectLocation(searchedLocations[index].name!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                searchedLocations[index].name!,
                style: AppStyles.bodySemiBoldXL,
              ),
              const SizedBox(height: 5),
              Text(
                "${searchedLocations[index].region!} ${searchedLocations[index].country!}",
              ),
              if (index != searchedLocations.length - 1)
                const Divider(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
